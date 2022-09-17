defmodule SageWeb.Admin.Config do
  def create_resources(_conn) do
    [
      accounts: [
        name: "Accounts",
        resources: [
          users: [schema: Sage.Accounts.User, admin: SageWeb.Admin.AccountsAdmin]
        ]
      ]
    ]
  end
end
