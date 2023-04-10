[
  import_deps: [:ecto, :ecto_sql, :phoenix, :ash, :ash_postgres],
  subdirectories: ["priv/*/migrations"],
  inputs: ["*.{ex,exs}", "{config,lib,test}/**/*.{ex,exs}", "priv/*/seeds.exs"]
]
