defmodule Sage.Surveys do
  alias Sage.Commanded

  alias Sage.Surveys.Commands.{
    CreateSurvey,
    ArchiveSurvey,
    UpdateSurveyTitle
  }

  def create_survey(%{user_id: user_id, title: title}) do
    with {:ok, command} =
           CreateSurvey.new(
             survey_id: Uniq.UUID.uuid7(),
             user_id: user_id,
             title: title
           ) do
      Commanded.dispatch(
        command,
        consistency: :strong,
        returning: :execution_result
      )
    else
      err -> err
    end
  end
end
