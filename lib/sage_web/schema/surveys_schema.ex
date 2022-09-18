defmodule SageWeb.Schema.SurveysSchema do
  use SageWeb, :resolver
  alias SageWeb.Resolvers.SurveysResolver

  object :survey do
    field! :id, :id
    field! :title, :string

    field! :questions, list_of!(:question)
  end

  object :query_surveys do
    field! :surveys, list_of!(:survey) do
      resolve &SurveysResolver.list_surveys/2
    end
  end

  input_object :survey_input do
    field :id, :id
    field! :title, :string
  end

  object :mutation_surveys do
    field! :create_survey, :survey do
      arg! :input, :survey_input

      resolve &SurveysResolver.create_survey/3
    end

    field! :edit_survey, :survey do
      arg! :input, :survey_input

      resolve &SurveysResolver.edit_survey/3
    end
  end
end
