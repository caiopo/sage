defmodule Sage.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start commanded application
      Sage.Commanded,
      # Start the Ecto repository
      Sage.Repo,
      # Start the Telemetry supervisor
      SageWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Sage.PubSub},
      # Start the Endpoint (http/https)
      SageWeb.Endpoint,

      # Domain supervisors
      Sage.Surveys.Supervisor
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
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
