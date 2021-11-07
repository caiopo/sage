defmodule SageWeb.Resolvers.Users do
  def get_user(_root, %{id: id}, _info) do
    case Sage.Accounts.get_user(id) do
      nil ->
        {:error, "User ID #{id} not found"}

      user ->
        {:ok, user}
    end
  end
end
