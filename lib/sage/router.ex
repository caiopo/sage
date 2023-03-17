defmodule Sage.Router do
  use Commanded.Commands.Router

  alias Sage.Accounts.Aggregates.User

  alias Sage.Accounts.Commands.{
    RegisterUser,
    ChangePassword
  }

  identify(User, by: :user_id, prefix: "user-")

  dispatch(
    [
      RegisterUser,
      ChangePassword
    ],
    to: User
  )

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
