defmodule Sage.Surveys.Registry do
  use Ash.Registry,
    extensions: [
      Ash.Registry.ResourceValidations
    ]

  entries do
    entry Sage.Surveys.Question
    entry Sage.Surveys.Survey
  end
end
