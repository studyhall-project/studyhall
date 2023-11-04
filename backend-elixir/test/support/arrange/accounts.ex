defmodule StudyHall.Arrange.Accounts do
  @moduledoc """
  A collection of functions that help tests arrange user within the system state
  in advance of testing logic.
  """

  alias StudyHall.Accounts.User

  @typedoc """
  Expected attribute map for creating a user.
  """
  @type incoming_user_attributes ::
          %{
            optional(:email) => String.t(),
            optional(:password) => String.t()
          }
          | nil

  @doc """
  Creates a user in the system with the given attributes.
  """
  @spec create_user!(incoming_user_attributes) :: User.t()
  def create_user!(incoming_user_attributes \\ %{}) do
    user_attributes = required_user_attributes(incoming_user_attributes)

    User.register_with_password!(
      user_attributes.email,
      user_attributes.password,
      user_attributes.password
    )
  end

  @spec required_user_attributes(map()) :: incoming_user_attributes
  def required_user_attributes(incoming_user_attributes) do
    incoming_user_attributes
    |> Map.put_new(:email, "user#{System.unique_integer()}@example.com")
    |> Map.put_new(:password, "some-long-valid-password")
  end
end
