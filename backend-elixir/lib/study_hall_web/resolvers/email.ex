defmodule StudyHallWeb.Resolvers.Email do
  @moduledoc """
  A simple resolver for sending test emails.
  """

  def email_zorn(_parent, %{message: message}, _resolution) do
    email = StudyHall.Emails.DemoMessage.new(message)

    case StudyHall.Mailer.deliver(email) do
      {:ok, _} -> {:ok, %{system_message: "email sent"}}
      {:error, reason} -> {:error, reason}
    end
  end
end
