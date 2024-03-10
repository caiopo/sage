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

# Configures the endpoint
config :sage, SageWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [json: SageWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Sage.PubSub,
  live_view: [signing_salt: "OG5LGXHD"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :sage, Sage.Mailer, adapter: Swoosh.Adapters.Local

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Ash
config :ash, :use_all_identities_in_manage_relationship?, false

config :ash_graphql, :default_managed_relationship_type_name_template, :action_name
config :ash_graphql, :allow_non_null_mutation_arguments?, true
config :ash_graphql, :json_type, :json

config :sage,
  ash_apis: [Sage.Accounts, Sage.Surveys],
  ecto_repos: [Sage.Repo],
  token_signing_secret: "sage"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
