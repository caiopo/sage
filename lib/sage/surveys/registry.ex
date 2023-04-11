defmodule Sage.Surveys.Registry do
  use Ash.Registry,
    extensions: [
      Ash.Registry.ResourceValidations
    ]

  entries do
    entry Sage.Surveys.Survey
    entry Sage.Surveys.Question
  end
end
