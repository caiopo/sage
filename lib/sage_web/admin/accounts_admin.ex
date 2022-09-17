defmodule SageWeb.Admin.AccountsAdmin do
  alias Sage.Accounts

  def widgets(_schema, _conn) do
    [
      %{
        type: "tidbit",
        title: "Number of Users",
        content: Accounts.count_users(),
        icon: "user",
        order: 1,
        width: 6
      }
    ]
  end
end
