defmodule Sage.MixProject do
  use Mix.Project

  def project do
    [
      app: :sage,
      version: "0.1.0",
      elixir: "~> 1.14",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Sage.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:absinthe_plug, "~> 1.5"},
      {:ash_admin, "~> 0.8"},
      {:ash_archival, "~> 0.1"},
      {:ash_authentication_phoenix, "~> 1.7"},
      {:ash_authentication, "~> 3.10"},
      {:ash_graphql, "~> 0.23.2"},
      {:ash_postgres, "~> 1.3"},
      {:ash, "~> 2.6"},
      {:ecto_sql, "~> 3.6"},
      {:finch, "~> 0.13"},
      {:jason, "~> 1.2"},
      {:phoenix_ecto, "~> 4.4"},
      {:phoenix_live_dashboard, "~> 0.7.2"},
      {:phoenix_live_view, "0.18.16"},
      {:phoenix, "~> 1.7.2"},
      {:plug_cowboy, "~> 2.5"},
      {:postgrex, ">= 0.0.0"},
      {:swoosh, "~> 1.3"},
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"},
      {:uniq, "~> 0.5.4"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "db.setup"],
      "db.setup": ["ash_postgres.create", "ash_postgres.migrate", "run priv/repo/seeds.exs"],
      "db.reset": ["ash_postgres.drop", "db.setup"],
      test: ["ash_postgres.create --quiet", "ash_postgres.migrate --quiet", "test"]
    ]
  end
end
