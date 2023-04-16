defmodule Sage.Accounts do
  use Ash.Api,
    extensions: [AshAdmin.Api, AshGraphql.Api]

  admin do
    show? true
  end

  graphql do
  end

  resources do
    registry Sage.Accounts.Registry
  end
end
