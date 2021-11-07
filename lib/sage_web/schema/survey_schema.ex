defmodule SageWeb.Schema.Survey do
  use Absinthe.Schema.Notation

  alias SageWeb.Resolvers

  enum :question_type do
    value(:single)
    value(:multi)
    value(:text)
    value(:number)
  end

  object :survey do
    field :uuid, non_null(:string)
    field :title, non_null(:string)
  end

  object :question do
    field :uuid, non_null(:string)
    field :title, non_null(:string)
    field :type, non_null(:question_type)
  end

  object :survey_queries do
    @desc "Get all surveys"
    field :surveys, non_null(list_of(non_null(:survey))) do
      resolve(&Resolvers.Surveys.list_surveys/3)
    end

    @desc "Get all questions for a specific survey"
    field :questions, non_null(list_of(non_null(:question))) do
      arg(:survey_uuid, non_null(:string))
      resolve(&Resolvers.Surveys.list_questions/3)
    end
  end
end
