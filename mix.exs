defmodule Sage.MixProject do
  use Mix.Project

  def project do
    [
      app: :sage,
      version: "0.1.0",
      elixir: "~> 1.12",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:domo_compiler] ++ Mix.compilers(),
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
  defp elixirc_paths(:dev), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:absinthe_plug, "~> 1.5"},
      {:bcrypt_elixir, "~> 3.0"},
      {:commanded_ecto_projections, "~> 1.3"},
      {:commanded_eventstore_adapter, "~> 1.4"},
      {:commanded, "~> 1.4"},
      {:domo, "~> 1.5"},
      {:ecto_psql_extras, "~> 0.7.4"},
      {:ecto_sql, "~> 3.6"},
      {:guardian, "~> 2.3"},
      {:jason, "~> 1.2"},
      {:kaffy, "~> 0.9.3"},
      {:phoenix_ecto, "~> 4.4"},
      {:phoenix_html, "~> 3.2"},
      {:phoenix_live_dashboard, "~> 0.6"},
      {:phoenix_view, "~> 2.0"},
      {:phoenix, "~> 1.7"},
      {:plug_cowboy, "~> 2.5"},
      {:postgrex, ">= 0.0.0"},
      {:shorter_maps, "~> 2.0"},
      {:swoosh, "~> 1.3"},
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"},
      {:typed_struct, "~> 0.3.0"},
      {:uniq, "~> 0.5.4"}
    ] ++ dev_deps()
  end

  defp dev_deps() do
    [
      {:assertions, "~> 0.19.0", only: [:test]},
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:ecto_sqlite3, ">= 0.0.0", only: [:dev, :test]},
      {:faker, "~> 0.17.0", only: [:dev, :test]},
      {:phoenix_live_reload, "~> 1.3", only: [:dev]}
    ]
  end

  defp aliases do
    [
      setup: ["deps.get", "db.setup"],
      "db.reset": [
        "ecto.drop --force-drop",
        "ecto.create",
        "ecto.migrate",
        "event_store.drop",
        "event_store.create",
        "event_store.init"
      ],
      "db.setup": [
        "db.reset",
        "run priv/repo/seeds.exs"
      ],
      test: ["ecto.drop --quiet", "ecto.create --quiet", "ecto.migrate --quiet", "test"]
    ]
  end
end
