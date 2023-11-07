defmodule StudyHallWeb.Schema do
  @moduledoc false

  use Absinthe.Schema

  @apis [
    StudyHall.Accounts,
    StudyHall.CourseCatalog
  ]

  use AshGraphql, apis: @apis

  query do
  end

  mutation do
    @desc "Send a test email to zorn."
    field :email_zorn, type: :email_result do
      arg(:message, non_null(:string))
      resolve(&StudyHallWeb.Resolvers.Email.email_zorn/3)
    end
  end

  object :email_result do
    field :system_message, :string
  end
end
