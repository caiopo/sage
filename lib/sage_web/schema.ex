defmodule SageWeb.Schema do
  use Absinthe.Schema

  alias SageWeb.Schema

  import_types(Schema.AccountsSchema)
  import_types(Schema.SurveysSchema)
  import_types(Schema.QuestionsSchema)

  query do
    import_fields(:query_accounts)
    import_fields(:query_surveys)
    import_fields(:query_questions)
  end

  mutation do
    import_fields(:mutation_accounts)
    import_fields(:mutation_surveys)
    import_fields(:mutation_questions)
  end

  alias SageWeb.Middlewares

  def middleware(middleware, field, object) do
    middleware
    |> Middlewares.RequireAuthentication.add(field, object)
    |> Middlewares.HandleChangesetErrors.add(field, object)
  end
end
