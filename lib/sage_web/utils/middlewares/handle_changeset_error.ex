defmodule SageWeb.Middlewares.HandleChangesetErrors do
  @behaviour Absinthe.Middleware
  def call(resolution, _) do
    %{resolution | errors: Enum.flat_map(resolution.errors, &handle_error/1)}
  end

  defp handle_error(%Ecto.Changeset{} = changeset) do
    changeset
    |> Ecto.Changeset.traverse_errors(fn {msg, opts} ->
      Regex.replace(~r"%{(\w+)}", msg, fn _, key ->
        opts |> Keyword.get(String.to_existing_atom(key), key) |> to_string()
      end)
    end)
    |> Enum.map(fn {k, v} -> "#{k}: #{v}" end)
  end

  defp handle_error(error), do: [error]

  def add(middleware, _field, %{identifier: :mutation}) do
    middleware ++ [SageWeb.Middlewares.HandleChangesetErrors]
  end

  def add(middleware, _field, _object), do: middleware
end
