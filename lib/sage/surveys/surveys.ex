defmodule Sage.Surveys do
  use Ash.Api,
    extensions: [AshAdmin.Api, AshGraphql.Api]

  admin do
    show? true
  end

  graphql do
  end

  resources do
    resource Sage.Surveys.Survey
    resource Sage.Surveys.Question
    resource Sage.Surveys.SurveyAnswer
    resource Sage.Surveys.QuestionAnswer
  end
end
