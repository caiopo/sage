defmodule Sage.Surveys do
  use Ash.Api,
    extensions: [AshAdmin.Api, AshGraphql.Api]

  admin do
    show? true
  end

  graphql do
  end

  resources do
    registry Sage.Surveys.Registry
  end
end
