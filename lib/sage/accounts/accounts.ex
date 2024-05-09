defmodule Sage.Accounts do
  use Ash.Domain,
    extensions: [AshAdmin.Domain, AshGraphql.Domain]

  admin do
    show? true
  end

  graphql do
  end

  resources do
    resource Sage.Accounts.User
    resource Sage.Accounts.Token
  end
end
