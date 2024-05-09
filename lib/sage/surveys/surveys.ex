defmodule Sage.Surveys do
  use Ash.Domain,
    extensions: [AshAdmin.Domain, AshGraphql.Domain]

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
