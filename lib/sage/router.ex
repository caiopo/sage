defmodule Sage.Router do
  use Commanded.Commands.Router

  alias Sage.Surveys.Aggregates.Survey

  alias Sage.Surveys.Commands.{
    CreateSurvey,
    UpdateSurveyTitle,
    ArchiveSurvey
  }

  identify(Survey, by: :survey_id, prefix: "survey-")

  dispatch(
    [
      CreateSurvey,
      UpdateSurveyTitle,
      ArchiveSurvey
    ],
    to: Survey
  )
end
