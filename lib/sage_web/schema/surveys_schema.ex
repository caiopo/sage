defmodule SageWeb.Schema.SurveysSchema do
  use SageWeb, :resolver
  alias SageWeb.Resolvers.SurveysResolver

  object :survey do
    field! :id, :id
    field! :title, :string

    field! :questions, list_of!(:question) do
      resolve &SurveysResolver.list_questions/3
    end
  end

  object :query_surveys do
    field! :surveys, list_of!(:survey) do
      resolve &SurveysResolver.list_surveys/2
    end
  end

  input_object :survey_input do
    field :id, :id
    field! :title, :string

    field! :questions, list_of!(:question_input)
  end

  input_object :question_input do
    field :id, :id
    field! :title, :string
    field! :type, :question_type

    field :options, list_of!(:string), description: "Only used by single and multi questions"

    field :min_length, :integer, description: "Inclusive. Only used by text questions."
    field :max_length, :integer, description: "Inclusive. Only used by text questions."

    field :min_value, :integer, description: "Inclusive. Only used by number questions."
    field :max_value, :integer, description: "Inclusive. Only used by number questions."
  end

  input_object :share_survey_input do
    field! :survey_id, :id
    field! :email, :string
  end

  object :mutation_surveys do
    field! :create_survey, :survey do
      arg! :input, :survey_input

      resolve &SurveysResolver.create_survey/2
    end

    field! :edit_survey, :survey do
      arg! :input, :survey_input

      resolve &SurveysResolver.edit_survey/2
    end

    field! :share_survey, :id do
      arg! :input, :share_survey_input

      resolve &SurveysResolver.share_survey/2
    end
  end
end
