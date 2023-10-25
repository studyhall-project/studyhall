defmodule StudyHall.Accounts.User do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    extensions: [
      AshAuthentication,
      AshGraphql.Resource
    ]

  postgres do
    table "users"
    repo StudyHall.Repo
  end

  attributes do
    uuid_primary_key :id
    attribute :email, :ci_string, allow_nil?: false
    attribute :hashed_password, :string, allow_nil?: false, sensitive?: true
  end

  actions do
    defaults [:read]

    read :by_id do
      argument :id, :uuid, allow_nil?: false
      get? true
      filter expr(id == ^arg(:id))
    end
  end

  code_interface do
    define_for StudyHall.Accounts

    define :read_all, action: :read
    define :get_by_id, args: [:id], action: :by_id
    define :register_with_password, args: [:email, :password, :password_confirmation]
  end

  graphql do
    type :user

    queries do
      get :get_user, :read
      list :list_users, :read
    end

    mutations do
      create :register_with_password, :register_with_password
    end
  end

  authentication do
    api StudyHall.Accounts

    strategies do
      password :password do
        identity_field :email
      end
    end

    tokens do
      enabled? true
      token_resource StudyHall.Accounts.Token

      signing_secret fn _, _ ->
        Application.fetch_env(:study_hall, :token_signing_secret)
      end
    end
  end

  identities do
    identity :unique_email, [:email]
  end

  # If using policies, add the folowing bypass:
  # policies do
  #   bypass AshAuthentication.Checks.AshAuthenticationInteraction do
  #     authorize_if always()
  #   end
  # end
end
