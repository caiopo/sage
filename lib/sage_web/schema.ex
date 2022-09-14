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
end
