defmodule StudyHallWeb.Api.EmailZornTest do
  use StudyHallWeb.ConnCase

  import Swoosh.TestAssertions

  @email_zorn_mutation """
  mutation emailZorn($message: String!) {
    emailZorn(message: $message) {
      systemMessage
    }
  }
  """

  test "mutation: emailZorn", ~M{conn} do
    conn =
      post(conn, "/gql", %{
        "query" => @email_zorn_mutation,
        "variables" => %{"message" => "a simple test message"}
      })

    assert response = json_response(conn, 200)
    assert %{"data" => %{"emailZorn" => %{"systemMessage" => "email sent"}}} = response

    # Verify during resolution of this graph api call, the email was sent.
    assert_email_sent(StudyHall.Emails.DemoMessage.new("a simple test message"))
  end
end
