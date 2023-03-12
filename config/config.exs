# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :sage,
  ecto_repos: [Sage.Repo],
  generators: [binary_id: true]

# Configures repo to use UTC datetimes
config :sage, Sage.Repo, migration_timestamps: [type: :utc_datetime_usec]

# Configures the endpoint
config :sage, SageWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: SageWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Sage.PubSub,
  live_view: [signing_salt: "nxaXgTua"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :sage, Sage.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :kaffy,
  otp_app: :sage,
  admin_title: "Sage Admin",
  ecto_repo: Sage.Repo,
  router: SageWeb.Router,
  resources: &SageWeb.Admin.Config.create_resources/1

config :sage, event_stores: [Sage.EventStore]

config :commanded_ecto_projections,
  repo: Sage.Repo

config :sage, Sage.Commanded,
  event_store: [
    adapter: Commanded.EventStore.Adapters.EventStore,
    event_store: Sage.EventStore
  ],
  pubsub: :local,
  registry: :local

config :domo,
  skip_defaults: true

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
