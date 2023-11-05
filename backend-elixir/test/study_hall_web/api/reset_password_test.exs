defmodule StudyHallWeb.Api.ResetPasswordTest do
  @moduledoc """
  Asserts expectations around account starting the request password user flow
  via the GraphQL API.
  """

  use StudyHallWeb.ConnCase

  import StudyHall.Arrange.Accounts
  import Swoosh.TestAssertions

  alias StudyHall.Accounts.User
  alias StudyHall.Accounts.Emails.ResetPassword

  test "success: given a known email, sends reset password email", %{conn: conn} do
    %User{email: email} = create_user!()
    email = Ash.CiString.to_comparable_string(email)
    conn = post_request_password_reset_mutation(conn, %{email: email})

    # The API response is `null` both when the email is known and unknown.
    assert %{"data" => %{"requestPasswordReset" => nil}} = json_response(conn, 200)

    assert_email_sent(fn email ->
      assert email.provider_options.template_alias == ResetPassword.template_alias()
    end)
  end

  test "failure: given an unknown email, does not send a reset password email", %{conn: conn} do
    conn = post_request_password_reset_mutation(conn, %{email: "missing@example.com"})

    # The API response is `null` both when the email is known and unknown.
    assert %{"data" => %{"requestPasswordReset" => nil}} = json_response(conn, 200)

    # No email for unknown user.
    refute_email_sent()
  end

  defp post_request_password_reset_mutation(conn, %{email: email}) do
    query = """
    mutation requestPasswordReset($email: String!) {
      requestPasswordReset(email: $email) {
        id
        email
      }
    }
    """

    post(conn, "/gql", %{
      "query" => query,
      "variables" => %{
        "email" => email
      }
    })
  end
end
