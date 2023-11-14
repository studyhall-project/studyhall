defmodule StudyHall.Accounts.User do
  @moduledoc """
  A User entity represents an individual who has registered to use the application.
  """

  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    extensions: [
      AshAuthentication,
      AshGraphql.Resource
    ]

  @type t :: %__MODULE__{
          id: Ecto.UUID.t(),
          email: Ash.CiString.t()
        }

  postgres do
    table "users"
    repo StudyHall.Repo
  end

  attributes do
    uuid_primary_key :id
    attribute :email, :ci_string, allow_nil?: false

    attribute :hashed_password, :string do
      allow_nil? false
      sensitive? true
      private? true
    end

    create_timestamp :inserted_at
    update_timestamp :updated_at
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
    define :sign_in_with_password, args: [:email, :password]
    define :request_password_reset, args: [:email]
    define :password_reset, args: [:reset_token, :password, :password_confirmation]
  end

  graphql do
    type :user

    queries do
      get :get_user, :read
      list :list_users, :read

      read_one :sign_in_with_password, :sign_in_with_password do
        as_mutation? true
        type_name :user_with_metadata
      end

      read_one :request_password_reset, :request_password_reset do
        as_mutation? true
      end
    end

    mutations do
      create :register_with_password, :register_with_password
      update :password_reset, :password_reset
    end
  end

  authentication do
    api StudyHall.Accounts

    # If you ever want to do introspection at the actions this generates use,
    # `Ash.Resource.Info.actions(StudyHall.Accounts.User)` inside an iex session.
    strategies do
      password :password do
        identity_field :email

        resettable do
          request_password_reset_action_name :request_password_reset
          password_reset_action_name :password_reset
          sender StudyHall.Accounts.Senders.SendResetPasswordEmail
        end
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
