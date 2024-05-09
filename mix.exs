defmodule Sage.MixProject do
  use Mix.Project

  def project do
    [
      app: :sage,
      version: "0.1.0",
      elixir: "~> 1.15",
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
      {:ash_admin, "~> 0.10.10-rc.1"},
      {:ash_archival, "~> 1.0.0-rc.1"},
      {:ash_authentication, "~> 4.0.0-rc.6"},
      {:ash_authentication_phoenix, "~> 2.0.0-rc.2"},
      {:ash_graphql, "~> 1.0.0-rc.5"},
      {:ash_postgres, "~> 2.0.0-rc.15"},
      {:ash, "~> 3.0.0-rc.46"},
      {:ecto_sql, "~> 3.11"},
      {:finch, "~> 0.18"},
      {:jason, "~> 1.4"},
      {:phoenix_ecto, "~> 4.5"},
      {:phoenix_live_dashboard, "~> 0.8"},
      {:phoenix_live_view, "~> 0.20"},
      {:phoenix, "~> 1.7"},
      {:plug_cowboy, "~> 2.7"},
      {:postgrex, ">= 0.0.0"},
      {:swoosh, "~> 1.15"},
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"},
      {:uniq, "~> 0.6"},
      {:assertions, "~> 0.19"},
      {:picosat_elixir, "~> 0.2"},
      {:atomic_map, "~> 0.9", only: [:dev, :test]},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.4", only: [:dev, :test], runtime: false},
      {:matcher, "~> 0.3", only: [:dev, :test]}
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
      "db.reset": ["ash_postgres.drop --force-drop", "db.setup"],
      test: ["ash_postgres.create --quiet", "ash_postgres.migrate --quiet", "test"],
      migration: ["ash_postgres.generate_migrations"],
      schema: ["absinthe.schema.sdl --schema Sage.Schema"]
    ]
  end
end
