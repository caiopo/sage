defmodule Sage.Surveys.Aggregates.Survey do
  use Sage.Struct

  typedstruct enforce: true do
    field :id, UUID.formatted(), enforce: false
    field :user_id, UUID.formatted()
    field :title, String.t()
  end

  alias Sage.Surveys.Aggregates.Survey

  alias Sage.Surveys.Commands.{
    CreateSurvey,
    ArchiveSurvey,
    UpdateSurveyTitle
  }

  alias Sage.Surveys.Events.{
    SurveyCreated,
    SurveyTitleUpdated
  }

  def execute(%Survey{id: nil}, %CreateSurvey{} = create) do
    %SurveyCreated{
      survey_id: create.survey_id,
      user_id: create.user_id,
      title: create.title
    }
  end

  def execute(%Survey{}, %UpdateSurveyTitle{} = update) do
    %SurveyTitleUpdated{
      survey_id: update.survey_id,
      title: update.title
    }
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
end
