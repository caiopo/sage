defmodule Sage.Accounts.UserToken do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    authorizers: [Ash.Policy.Authorizer],
    extensions: [AshAuthentication.TokenResource]

  token do
    api Sage.Accounts
  end

  policies do
    bypass AshAuthentication.Checks.AshAuthenticationInteraction do
      authorize_if always()
    end
  end

  postgres do
    table "user_tokens"
    repo Sage.Repo
  end
end
