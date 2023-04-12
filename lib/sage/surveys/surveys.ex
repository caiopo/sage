defmodule Sage.Surveys do
  use Ash.Api,
    extensions: [AshAdmin.Api, AshGraphql.Api]

  admin do
    show? true
  end

  graphql do
    # Defaults to `true`, use this to disable authorization for the entire API (you probably only want this while prototyping)
    authorize? false
  end

  resources do
    registry Sage.Surveys.Registry
  end
end
