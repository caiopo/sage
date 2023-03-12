defmodule Sage.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Sage.Commanded,
      Sage.Repo,
      SageWeb.Telemetry,
      {Phoenix.PubSub, name: Sage.PubSub},
      SageWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: Sage.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SageWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
