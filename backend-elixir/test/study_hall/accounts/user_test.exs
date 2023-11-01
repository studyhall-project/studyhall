defmodule StudyHall.Accounts.UserTest do
  use StudyHall.DataCase
  import Ash.CiString, only: [sigil_i: 2]
  alias StudyHall.Accounts.User

  describe "register_with_password/3" do
    test "success: creates a user with valid arguments" do
      email = "mike@mikezornek.com"
      password = "some-long-valid-password"
      password_confirmation = "some-long-valid-password"

      assert {:ok, user} =
               User.register_with_password(
                 email,
                 password,
                 password_confirmation
               )

      expected_email = ~i"mike@mikezornek.com"
      assert %User{email: ^expected_email} = user
    end

    test "fails: with a short password" do
      email = "mike@mikezornek.com"
      password = "short"
      password_confirmation = "short"

      assert {:error, _ash_error} =
               User.register_with_password(
                 email,
                 password,
                 password_confirmation
               )

      # normally I'd do something like:
      # assert "should be at least 8 character(s)" in errors_on(changeset).password

      # Q: What function should I lean on to extract error strings per field from `Ash.Error`?

      # A: Going to try calling this action from the GraphQL and see how it styles the message. May end up only testing that.

      # dbg(ash_error)
      # assert false
    end
  end
end
