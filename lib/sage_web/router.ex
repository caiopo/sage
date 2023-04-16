defmodule SageWeb.Router do
  use SageWeb, :router

  import AshAdmin.Router
  import AshAuthentication.Plug.Helpers

  def read_token(conn) do
    IO.inspect(conn)
    conn
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :retrieve_from_bearer, :sage
    plug :set_actor, :user
  end

  admin_browser_pipeline(:browser)

  scope "/admin" do
    # Pipe it through your browser pipeline
    pipe_through [:browser]

    ash_admin("/")
  end

  scope "/api", SageWeb do
    pipe_through :api
  end

  pipeline :graphql do
    plug AshGraphql.Plug
  end

  scope "/" do
    pipe_through [:api, :graphql]

    forward "/graphql", Absinthe.Plug, schema: Sage.Schema

    forward "/playground",
            Absinthe.Plug.GraphiQL,
            schema: Sage.Schema,
            interface: :playground
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:sage, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: SageWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
