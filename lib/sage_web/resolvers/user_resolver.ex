defmodule SageWeb.Resolvers.Users do
  def get_current_user(_root, _attrs, %{context: %{current_user: current_user}}) do
    {:ok, current_user}
  end
end
