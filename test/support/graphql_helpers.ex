defmodule SageWeb.GraphqlHelpers do
  defmacro send_query(conn, query, variables \\ nil) do
    quote do
      unquote(conn)
      |> post("/graphql", %{
        "query" => unquote(query),
        "variables" => unquote(variables)
      })
      |> json_response(200)
    end
  end
end
