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

  def middleware(middleware, _field, %{identifier: :mutation}) do
    middleware ++ [SageWeb.Middlewares.HandleChangesetErrors]
  end

  def middleware(middleware, _field, _object), do: middleware
end
