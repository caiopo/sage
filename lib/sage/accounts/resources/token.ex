defmodule Sage.Accounts.Token do
  use Ash.Resource,
    domain: Sage.Accounts,
    data_layer: AshPostgres.DataLayer,
    authorizers: [Ash.Policy.Authorizer],
    extensions: [AshAuthentication.TokenResource]

  # token do
  #   domain Sage.Accounts
  # end

  policies do
    bypass AshAuthentication.Checks.AshAuthenticationInteraction do
      authorize_if always()
    end
  end

  postgres do
    table "tokens"
    repo Sage.Repo
  end
end
