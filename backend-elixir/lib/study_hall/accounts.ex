defmodule StudyHall.Accounts do
  use Ash.Api

  resources do
    resource StudyHall.Accounts.User
    resource StudyHall.Accounts.Token
  end
end
