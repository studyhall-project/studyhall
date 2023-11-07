defmodule StudyHallWeb.Api.RegistrationTest do
  @moduledoc """
  Asserts expectations around account creation via the GraphQL API.
  """

  use StudyHallWeb.ConnCase

  import Ash.CiString, only: [sigil_i: 2]
  import StudyHall.Arrange.Accounts

  alias StudyHall.Accounts.User

  test "success: can register with valid params", %{conn: conn} do
    conn = post_register_with_password_mutation(conn, %{email: "amy@example.com"})

    # Assert successful Graph API response.
    assert %{
             "data" => %{
               "registerWithPassword" => %{
                 "errors" => [],
                 "metadata" => %{
                   "token" => _token
                 },
                 "result" => %{
                   "email" => "amy@example.com",
                   "id" => id
                 }
               }
             }
           } = json_response(conn, 200)

    # Assert the user is in now in the database.
    expected_email = ~i"amy@example.com"
    assert %User{email: ^expected_email} = User.get_by_id!(id)
  end

  test "failure: requires long passwords", %{conn: conn} do
    conn =
      post_register_with_password_mutation(conn, %{
        password: "short",
        password_confirmation: "short"
      })

    assert %{
             "data" => %{
               "registerWithPassword" => %{
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

  test "failure: requires confirmation to match password", %{conn: conn} do
    conn =
      post_register_with_password_mutation(conn, %{
        password: "password",
        password_confirmation: "password-nomatch"
      })

    assert %{
             "data" => %{
               "registerWithPassword" => %{
                 "errors" => [
                   %{
                     "fields" => ["password_confirmation"],
                     "shortMessage" => "does not match"
                   }
                 ],
                 "metadata" => nil,
                 "result" => nil
               }
             }
           } = json_response(conn, 200)
  end

  test "failure: can not register with an email already in the system", %{conn: conn} do
    user = create_user!()
    conn = post_register_with_password_mutation(conn, %{email: Ash.CiString.value(user.email)})

    assert %{
             "data" => %{
               "registerWithPassword" => %{
                 "errors" => [
                   %{
                     "fields" => ["email"],
                     "shortMessage" => "has already been taken"
                   }
                 ]
               }
             }
           } = json_response(conn, 200)
  end

  defp post_register_with_password_mutation(conn, attrs) do
    attrs = required_user_attributes(attrs)

    query = """
    mutation registerWithPassword($input: RegisterWithPasswordInput) {
      registerWithPassword(input: $input) {
        result {
          id
          email
        }
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
      }
    }
    """

    post(conn, "/gql", %{
      "query" => query,
      "variables" => %{
        "input" => %{
          "email" => attrs.email,
          "password" => attrs.password,
          "passwordConfirmation" => attrs.password_confirmation
        }
      }
    })
  end
end
