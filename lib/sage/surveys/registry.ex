defmodule Sage.Surveys.Registry do
  use Ash.Registry,
    extensions: [
      # This extension adds helpful compile time validations
      Ash.Registry.ResourceValidations
    ]

  entries do
    entry Sage.Surveys.Survey
    entry Sage.Surveys.Question
  end
end
