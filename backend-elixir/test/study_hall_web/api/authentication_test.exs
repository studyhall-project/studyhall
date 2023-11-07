defmodule StudyHallWeb.Api.AuthenticationTest do
  @moduledoc """
  Asserts expectations around account authentication via the GraphQL API.
  """

  use StudyHallWeb.ConnCase

  import StudyHall.Arrange.Accounts

  alias StudyHall.Accounts.User

  test "success: returns a token when sending in a valid password", ~M{conn} do
    password = "passwords-are-fun"
    %User{id: id, email: email} = create_user!(%{password: password})
    email = Ash.CiString.to_comparable_string(email)

    conn = post_sign_in_with_password_mutation(conn, %{email: email, password: password})

    assert %{
             "data" => %{
               "signInWithPassword" => %{
                 "email" => ^email,
                 "id" => ^id,
                 "token" => _token
               }
             }
           } = json_response(conn, 200)
  end

  test "failure: does not work with an invalid password", ~M{conn} do
    %User{email: email} = create_user!(%{password: "passwords-are-fun"})
    email = Ash.CiString.to_comparable_string(email)
    conn = post_sign_in_with_password_mutation(conn, %{email: email, password: "wrong-password"})

    assert %{
             "data" => %{
               "signInWithPassword" => nil
             },
             "errors" => [
               %{
                 "message" => "could not sign in with the provided credentials",
                 "shortMessage" => "could not sign in with the provided credentials"
               }
             ]
           } = json_response(conn, 200)
  end

  test "failure: does not work with for email not in system", ~M{conn} do
    conn =
      post_sign_in_with_password_mutation(conn, %{
        email: "missing-user@example.com",
        password: "password"
      })

    # Note: The error message here does not leak that the email in question is
    # or is not in the system.
    assert %{
             "data" => %{
               "signInWithPassword" => nil
             },
             "errors" => [
               %{
                 "message" => "could not sign in with the provided credentials",
                 "shortMessage" => "could not sign in with the provided credentials"
               }
             ]
           } = json_response(conn, 200)
  end

  defp post_sign_in_with_password_mutation(conn, ~M{email, password}) do
    query = """
    mutation signInWithPassword($email: String!, $password: String!) {
      signInWithPassword(email: $email, password: $password) {
        id
        email
        token
      }
    }
    """

    post(conn, "/gql", %{
      "query" => query,
      "variables" => %{
        "email" => email,
        "password" => password
      }
    })
  end
end
