# I created this during the tutorial but I don't think I'll be using it.
defmodule StudyHall.Accounts.Token do
  @moduledoc false

  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshAuthentication.TokenResource]

  token do
    api StudyHall.Accounts
  end

  postgres do
    table "tokens"
    repo StudyHall.Repo
  end

  # If using policies, add the following bypass:
  # policies do
  #   bypass AshAuthentication.Checks.AshAuthenticationInteraction do
  #     authorize_if always()
  #   end
  # end
end
