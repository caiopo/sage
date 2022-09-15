defmodule SageWeb.Middlewares.PublicResolver do
  @behaviour Absinthe.Middleware

  def call(resolution, _config) do
    %{resolution | context: Map.put(resolution.context, :public, true)}
  end
end
