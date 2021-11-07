defmodule SageWeb.Schema do
  use Absinthe.Schema

  import_types(Absinthe.Type.Custom)
  import_types(SageWeb.Schema.User)

  query do
    import_fields(:user_queries)
  end
end
