defmodule Sage.Surveys do
  use Ash.Api

  resources do
    registry Sage.Surveys.Registry
  end
end
