import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :sage, Sage.Repo,
  database: "db/db-test.sqlite3",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :sage, SageWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "+rJpGrxQ5oIpESG3SYMJgVlGA+gj1QCoc+DuQCwnZQZn8Z2hbYYxAqcqOPkce0mm",
  server: false

# In test we don't send emails.
config :sage, Sage.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
