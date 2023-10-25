defmodule StudyHall.Accounts do
  use Ash.Api,
    extensions: [
      AshGraphql.Api
    ]

  graphql do
    # Defaults to `true`, use this to disable authorization for the entire API
    # (you probably only want this while prototyping)
    authorize? false
  end

  resources do
    resource StudyHall.Accounts.User
    resource StudyHall.Accounts.Token
  end
end
