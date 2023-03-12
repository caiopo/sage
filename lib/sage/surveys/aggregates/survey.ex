defmodule Sage.Surveys.Aggregates.Survey do
  use Sage.Struct

  typedstruct enforce: true do
    field :id, UUID.formatted(), enforce: false
    field :user_id, UUID.formatted()
    field :title, String.t()
    field :archived_at, DateTime.t() | nil
  end

  alias Sage.Surveys.Aggregates.Survey

  alias Sage.Surveys.Commands.{
    CreateSurvey,
    ArchiveSurvey,
    UpdateSurveyTitle
  }

  alias Sage.Surveys.Events.{
    SurveyCreated,
    SurveyTitleUpdated,
    SurveyArchived
  }

  def execute(%Survey{id: nil}, %CreateSurvey{} = command) do
    SurveyCreated.new!(
      survey_id: command.survey_id,
      user_id: command.user_id,
      title: command.title
    )
  end

  def execute(%Survey{id: nil}, %UpdateSurveyTitle{}),
    do: {:error, "Cannot update title of nonexistent survey"}

  def execute(%Survey{}, %UpdateSurveyTitle{} = command) do
    SurveyTitleUpdated.new!(
      survey_id: command.survey_id,
      title: command.title
    )
  end

  def execute(%Survey{id: nil}, %ArchiveSurvey{}),
    do: {:error, "Cannot archive nonexistent survey"}

  def execute(%Survey{}, %ArchiveSurvey{} = command) do
    SurveyArchived.new!(
      survey_id: command.survey_id,
      archived_at: command.archived_at
    )
  end

  def apply(%Survey{} = survey, %SurveyCreated{} = created) do
    %Survey{
      survey
      | id: created.survey_id,
        user_id: created.user_id,
        title: created.title
    }
  end

  def apply(%Survey{} = survey, %SurveyTitleUpdated{} = updated) do
    %Survey{
      survey
      | title: updated.title
    }
  end

  def apply(%Survey{} = survey, %SurveyArchived{} = event) do
    %Survey{
      survey
      | archived_at: event.archived_at
    }
  end
end
