defmodule StudyHall.Accounts.User do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshAuthentication]

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
