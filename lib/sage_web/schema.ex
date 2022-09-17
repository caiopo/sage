defmodule SageWeb.Schema do
  use Absinthe.Schema

  alias SageWeb.Schema

  import_types(Schema.AccountsSchema)

  query do
    import_fields(:query_accounts)
  end

  mutation do
    import_fields(:mutation_accounts)
  end

  alias SageWeb.Middlewares

  def middleware(middleware, field, object) do
    middleware
    |> Middlewares.RequireAuthentication.add(field, object)
    |> Middlewares.HandleChangesetErrors.add(field, object)
  end
end
