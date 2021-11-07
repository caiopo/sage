defmodule SageWeb.Schema do
  use Absinthe.Schema

  import_types(Absinthe.Type.Custom)
  import_types(SageWeb.Schema.User)
  import_types(SageWeb.Schema.Survey)

  query do
    import_fields(:user_queries)
    import_fields(:survey_queries)
  end
end
