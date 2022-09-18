defmodule SageWeb.Router do
  use SageWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", SageWeb do
    pipe_through :api
  end

  pipeline :authenticate_admin do
    if Mix.env() == :prod do
      plug :auth

      defp auth(conn, opts) do
        Plug.BasicAuth.basic_auth(conn, Application.fetch_env!(:sage, :basic_auth))
      end
    end
  end

  # Enables Kaffy admin dashboard
  use Kaffy.Routes, scope: "/admin", pipe_through: [:authenticate_admin]

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  import Phoenix.LiveDashboard.Router

  scope "/" do
    pipe_through [:fetch_session, :protect_from_forgery, :authenticate_admin]

    live_dashboard "/status",
      metrics: SageWeb.Telemetry,
      ecto_repos: [Sage.Repo],
      ecto_psql_extras_options: [long_running_queries: [threshold: "200 milliseconds"]]
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  pipeline :graphql do
    plug SageWeb.Context
  end

  scope "/graphql" do
    pipe_through :graphql

    forward "/", Absinthe.Plug, schema: SageWeb.Schema
  end

  scope "/graphiql" do
    pipe_through :graphql

    forward "/", Absinthe.Plug.GraphiQL, schema: SageWeb.Schema, interface: :playground
  end
end
