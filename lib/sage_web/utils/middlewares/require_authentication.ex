defmodule SageWeb.Middlewares.RequireAuthentication do
  @behaviour Absinthe.Middleware

  def call(resolution, _config) do
    case resolution.context do
      %{public: true} ->
        resolution

      %{current_user: _} ->
        resolution

      _ ->
        resolution
        |> Absinthe.Resolution.put_result({:error, "Unauthenticated"})
    end
  end

  def add(middleware, _field, %Absinthe.Type.Object{identifier: identifier})
      when identifier in [:query, :subscription, :mutation] do
    index =
      Enum.find_index(middleware, fn m ->
        case m do
          {{SageWeb.Middlewares.PublicResolver, :call}, []} -> true
          _ -> false
        end
      end) || -1

    List.insert_at(middleware, index + 1, SageWeb.Middlewares.RequireAuthentication)
  end

  def add(middleware, _field, _object), do: middleware
end
