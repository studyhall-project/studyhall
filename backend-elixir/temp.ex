# TODO
# Add plug: https://ash-hq.org/docs/guides/ash_graphql/latest/authorize-with-graphql

Helpdesk.Support.Ticket
|> Ash.Changeset.for_create(:create)
|> Helpdesk.Support.create!()

StudyHall.Accounts.User
|> Ash.Changeset.for_create(:register_with_password, %{
  email: "mike@mikezornek.com",
  password: "abc",
  password_confirmation: "abc"
})
|> StudyHall.Accounts.create()

StudyHall.Accounts.User
|> Ash.Changeset.for_create(:create, %{
  email: "mike@mikezornek.com",
  password: "abc",
  password_confirmation: "abc"
})
|> StudyHall.Accounts.create()

Ash.Resource.Info.actions(StudyHall.Accounts.User)
Ash.Resource.Info.actions(StudyHall.Accounts)

[
  %Ash.Resource.Actions.Read{
    arguments: [
      %Ash.Resource.Actions.Argument{
        allow_nil?: false,
        type: Ash.Type.CiString,
        name: :email,
        default: nil,
        private?: false,
        sensitive?: false,
        description: "The identity to use for retrieving the user.",
        constraints: [casing: nil, allow_empty?: false, trim?: true]
      },
      %Ash.Resource.Actions.Argument{
        allow_nil?: false,
        type: Ash.Type.String,
        name: :password,
        default: nil,
        private?: false,
        sensitive?: true,
        description: "The password to check for the matching user.",
        constraints: [allow_empty?: false, trim?: true]
      }
    ],
    description: "Attempt to sign in using a username and password.",
    filter: nil,
    get_by: [],
    get?: true,
    manual: nil,
    metadata: [
      %Ash.Resource.Actions.Metadata{
        allow_nil?: false,
        type: Ash.Type.String,
        name: :token,
        default: nil,
        description: "A JWT which the user can use to authenticate to the API.",
        constraints: [allow_empty?: false, trim?: true]
      }
    ],
    modify_query: nil,
    name: :sign_in_with_password,
    pagination: false,
    preparations: [
      %Ash.Resource.Preparation{
        preparation: {AshAuthentication.Strategy.Password.SignInPreparation, []}
      }
    ],
    primary?: false,
    touches_resources: [],
    transaction?: false,
    type: :read
  },
  %Ash.Resource.Actions.Create{
    name: :register_with_password,
    primary?: false,
    description: "Register a new user with a username and password.",
    error_handler: nil,
    accept: [:email],
    manual: nil,
    touches_resources: [],
    require_attributes: [],
    delay_global_validations?: false,
    skip_global_validations?: false,
    upsert?: false,
    upsert_identity: nil,
    upsert_fields: nil,
    arguments: [
      %Ash.Resource.Actions.Argument{
        allow_nil?: false,
        type: Ash.Type.String,
        name: :password,
        default: nil,
        private?: false,
        sensitive?: true,
        description: "The proposed password for the user, in plain text.",
        constraints: [allow_empty?: false, trim?: true, min_length: 8]
      },
      %Ash.Resource.Actions.Argument{
        allow_nil?: false,
        type: Ash.Type.String,
        name: :password_confirmation,
        default: nil,
        private?: false,
        sensitive?: true,
        description: "The proposed password for the user (again), in plain text.",
        constraints: [allow_empty?: false, trim?: true, min_length: 8]
      }
    ],
    changes: [
      %Ash.Resource.Validation{
        validation: {AshAuthentication.Strategy.Password.PasswordConfirmationValidation, []},
        module: AshAuthentication.Strategy.Password.PasswordConfirmationValidation,
        opts: [],
        only_when_valid?: false,
        description:
          "Confirm that the values of `:password` and `:password_confirmation` are the same if confirmation is enabled.",
        message: nil,
        before_action?: false,
        where: [],
        on: []
      },
      %Ash.Resource.Change{
        change: {AshAuthentication.Strategy.Password.HashPasswordChange, []},
        on: nil,
        only_when_valid?: false,
        description:
          "Generate a cryptographic hash of the user's plain text password and store it in the `:hashed_password` attribute.",
        where: []
      },
      %Ash.Resource.Change{
        change: {AshAuthentication.GenerateTokenChange, []},
        on: nil,
        only_when_valid?: false,
        description:
          "If token generation is enabled, generate a token and store it in the user's metadata.",
        where: []
      }
    ],
    allow_nil_input: [:hashed_password],
    reject: [],
    metadata: [
      %Ash.Resource.Actions.Metadata{
        allow_nil?: false,
        type: Ash.Type.String,
        name: :token,
        default: nil,
        description: "A JWT which the user can use to authenticate to the API.",
        constraints: [allow_empty?: false, trim?: true]
      }
    ],
    transaction?: true,
    type: :create
  },
  %Ash.Resource.Actions.Read{
    arguments: [],
    description: nil,
    filter: nil,
    get_by: [],
    get?: true,
    manual: nil,
    metadata: [],
    modify_query: nil,
    name: :get_by_subject,
    pagination: false,
    preparations: [],
    primary?: false,
    touches_resources: [],
    transaction?: false,
    type: :read
  },
  %Ash.Resource.Actions.Read{
    arguments: [],
    description: nil,
    filter: nil,
    get_by: [],
    get?: false,
    manual: nil,
    metadata: [],
    modify_query: nil,
    name: :read,
    pagination: false,
    preparations: [],
    primary?: true,
    touches_resources: [],
    transaction?: false,
    type: :read
  }
]
