defimpl AshGraphql.Error, for: AshAuthentication.Errors.AuthenticationFailed do
  @moduledoc """
  Provides an implementation of `AshGraphql.Error` protocol for authentication errors
  that come out of the `AshAuthentication` library.

  You can find other implementations here:
  https://github.com/ash-project/ash_graphql/blob/main/lib/error.ex
  """

  def to_error(error) do
    # The `AuthenticationFailed` actually has detailed information about the
    # error, like `Password is not valid` or `query returned no users` but we do
    # not want to leak those details over the API, so we'll return a static
    # error message.
    %{
      message: "could not sign in with the provided credentials",
      shortMessage: "could not sign in with the provided credentials",
      vars: Map.new(error.vars),
      code: Ash.ErrorKind.code(error),
      fields: List.wrap(error.field)
    }
  end
end
