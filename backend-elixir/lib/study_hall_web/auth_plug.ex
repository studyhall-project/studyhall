defmodule StudyHallWeb.AuthPlug do
  use AshAuthentication.Plug, otp_app: :my_app

  def handle_success(conn, _activity, user, token) do
    if is_api_request?(conn) do
      conn
      |> send_resp(200, Jason.encode!(%{
        authentication: %{
          success: true,
          token: token
        }
      }))
    else
      conn
      |> store_in_session(user)
      |> send_resp(200, EEx.eval_string("""
      <h2>Welcome back <%= @user.email %></h2>
      """, user: user))
    end
  end

  def handle_failure(conn, _activity, _reason) do
    if is_api_request?(conn) do
      conn
      |> send_resp(401, Jason.encode!(%{
        authentication: %{
          success: false
        }
      }))
    else
      conn
      |> send_resp(401, "<h2>Incorrect email or password</h2>")
    end
  end

  defp is_api_request?(conn), do: "application/json" in get_req_header(conn, "accept")
end
