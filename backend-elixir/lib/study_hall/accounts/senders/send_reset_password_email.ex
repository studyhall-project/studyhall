defmodule StudyHall.Accounts.Senders.SendResetPasswordEmail do
  @moduledoc """
  An `AshAuthentication` Sender, which knows how to send a password reset email.
  """

  use AshAuthentication.Sender

  alias StudyHall.Accounts.Emails.ResetPassword

  @impl AshAuthentication.Sender
  def send(user, token, _) do
    reset_url = "#{frontend_url()}/reset-password?user_id=#{user.id}&token=#{token}"
    support_url = "#{frontend_url()}/support"
    email = ResetPassword.new(user, reset_url, support_url)

    case StudyHall.Mailer.deliver(email) do
      {:ok, _} ->
        :ok

      {:error, reason} ->
        # FIXME: Add Sentry error capture for failed delivery.
        # https://github.com/studyhall-project/studyhall/issues/130

        # AshAuthentication.Sender current is documented as the return value
        # here is ignored, but we'll return the error tuple anyways.
        {:error, reason}
    end
  end

  defp frontend_url do
    Application.get_env(:studyhall, :frontend_url, "http://localhost:5173")
  end
end
