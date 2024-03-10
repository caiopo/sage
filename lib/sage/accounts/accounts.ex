defmodule Sage.Accounts do
  use Ash.Api,
    extensions: [AshAdmin.Api, AshGraphql.Api]

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
