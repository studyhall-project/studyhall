defmodule StudyHall.Accounts.Emails.ResetPassword do
  @moduledoc """
  An email we'll send to the user, providing them a link to reset their password.
  """

  import Swoosh.Email, except: [new: 0]

  alias StudyHall.Accounts.User

  def template_alias, do: "password-reset"

  @doc """
  Creates a reset password `Swoosh.Email` given a `User`, `reset_url`, and `support_url`.
  """
  @spec new(User.t(), reset_url :: String.t(), support_url :: String.t()) :: Swoosh.Email.t()
  def new(user, reset_url, support_url) do
    to_user_email = Ash.CiString.to_comparable_string(user.email)

    Swoosh.Email.new()
    |> from({"StudyHall Support", "support@studyhall.foo"})
    |> to({"", to_user_email})
    |> put_provider_option(:template_alias, template_alias())
    |> put_provider_option(:template_model, %{
      product_url: "https://github.com/studyhall-project/studyhall",
      product_name: "StudyHall",
      action_url: reset_url,
      support_url: support_url,
      company_name: "StudyHall, c/o Mike Zornek",
      company_address: "709 N 2nd St, 3rd Floor, Philadelphia, PA 19123"
    })
  end
end
