[
  import_deps: [:ecto, :phoenix, :plug, :absinthe, :typed_struct],
  inputs: ["*.{ex,exs}", "priv/*/seeds.exs", "{config,lib,test}/**/*.{ex,exs}"],
  subdirectories: ["priv/*/migrations"],
  locals_without_parens: [
    field: 2,
    field!: 2,
    field!: 3,
    arg!: 2,
    arg: 2,
    list_of!: 1
  ]
]
