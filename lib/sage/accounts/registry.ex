defmodule Sage.Accounts.Registry do
  use Ash.Registry,
    extensions: [
      Ash.Registry.ResourceValidations
    ]

  entries do
    entry Sage.Accounts.User
    entry Sage.Accounts.Token
  end
end
