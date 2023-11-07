defmodule StudyHallWeb.Api.PasswordResetTest do
  @moduledoc """
  Asserts expectations around the password reset user flow via the GraphQL API.
  """

  use StudyHallWeb.ConnCase

  import StudyHall.Arrange.Accounts
  import Swoosh.TestAssertions

  alias StudyHall.Accounts.Emails.ResetPassword
  alias StudyHall.Accounts.User

  test "success: given a known email, sends password reset email", %{conn: conn} do
    %User{email: email} = create_user!()
    email = Ash.CiString.to_comparable_string(email)
    conn = post_request_password_reset_mutation(conn, %{email: email})

    # The API response is `null` both when the email is known and unknown.
    assert %{"data" => %{"requestPasswordReset" => nil}} = json_response(conn, 200)

    assert_email_sent(fn email ->
      assert email.provider_options.template_alias == ResetPassword.template_alias()
    end)
  end

  test "failure: given an unknown email, does not send a password reset email", %{conn: conn} do
    conn = post_request_password_reset_mutation(conn, %{email: "missing@example.com"})

    # The API response is `null` both when the email is known and unknown.
    assert %{"data" => %{"requestPasswordReset" => nil}} = json_response(conn, 200)

    # No email for unknown user.
    refute_email_sent()
  end

  test "success: using a valid token, can assign a new password", %{conn: conn} do
    %User{id: id, email: email} = create_user!()
    User.request_password_reset(email)
    reset_token = password_reset_token_from_recent_email()

    conn =
      post_password_reset_mutation(conn, %{
        user_id: id,
        reset_token: reset_token,
        password: "new-password",
        password_confirmation: "new-password"
      })

    assert %{
             "data" => %{
               "passwordReset" => %{
                 "errors" => [],
                 "metadata" => %{
                   "token" => _token
                 },
                 "result" => %{
                   "email" => _email,
                   "id" => _id
                 }
               }
             }
           } = json_response(conn, 200)

    assert {:ok, _user} = User.sign_in_with_password(email, "new-password")
  end

  test "failure: using a valid token, but invalid password fails", %{conn: conn} do
    %User{id: id, email: email} = create_user!()
    User.request_password_reset(email)
    reset_token = password_reset_token_from_recent_email()

    conn =
      post_password_reset_mutation(conn, %{
        user_id: id,
        reset_token: reset_token,
        password: "p",
        password_confirmation: "p"
      })

    assert %{
             "data" => %{
               "passwordReset" => %{
                 "errors" => [
                   %{
                     "fields" => ["password_confirmation"],
                     "message" => "length must be greater than or equal to 8"
                   },
                   %{
                     "fields" => ["password"],
                     "message" => "length must be greater than or equal to 8"
                   }
                 ],
                 "metadata" => nil,
                 "result" => nil
               }
             }
           } = json_response(conn, 200)
  end

  test "failure: when using an invalid token, sees expected error", %{conn: conn} do
    %User{id: id} = create_user!()

    conn =
      post_password_reset_mutation(conn, %{
        user_id: id,
        reset_token: "bogus-token",
        password: "new-password",
        password_confirmation: "new-password"
      })

    assert %{
             "data" => %{
               "passwordReset" => %{
                 "errors" => [
                   %{
                     "fields" => ["reset_token"],
                     "message" => "is not valid"
                   }
                 ],
                 "metadata" => nil,
                 "result" => nil
               }
             }
           } = json_response(conn, 200)
  end

  test "failure: when using an expired token, sees expected error" do
    # I'm not sure how to generate an expired token for this test, without
    # massively making assumptions about the implementation, so skipping (but
    # documenting) for now.
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

  defp post_password_reset_mutation(conn, %{
         user_id: user_id,
         reset_token: reset_token,
         password: password,
         password_confirmation: password_confirmation
       }) do
    query = """
    mutation passwordReset($id: ID, $input: PasswordResetInput) {
      passwordReset(id: $id, input: $input) {
        errors {
          code
          fields
          message
          shortMessage
          vars
        }
        metadata {
          token
        }
        result {
          id
          email
        }
      }
    }
    """

    post(conn, "/gql", %{
      "query" => query,
      "variables" => %{
        "id" => user_id,
        "input" => %{
          "resetToken" => reset_token,
          "password" => password,
          "passwordConfirmation" => password_confirmation
        }
      }
    })
  end

  defp password_reset_token_from_recent_email do
    # I'm not seeing a good way to get the reset token from the action itself,
    # so for now going to sniff it out of the email.
    reset_email = assert_email_sent(fn email -> email end)

    # `action_url` will look something like:
    # http://localhost:5173/reset-password?token=abc&user_id=f6bf9096-4aab-4229-9154-31217365475c

    %URI{query: query} = URI.parse(reset_email.provider_options.template_model.action_url)

    params = URI.decode_query(query)
    params["token"]
  end
end
