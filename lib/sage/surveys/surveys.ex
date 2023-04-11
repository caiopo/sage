defmodule Sage.Surveys do
  use Ash.Api,
    extensions: [AshAdmin.Api]

  admin do
    show? true
  end

  resources do
    registry Sage.Surveys.Registry
  end
end
