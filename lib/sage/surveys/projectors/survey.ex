defmodule Sage.Surveys.Projectors.Survey do
  use Commanded.Projections.Ecto,
    application: Sage.Commanded,
    name: "Surveys.Projectors.Survey",
    consistency: :strong

  alias Sage.Surveys.Events.{
    SurveyCreated,
    SurveyTitleUpdated,
    SurveyArchived
  }

  alias Sage.Surveys.Projections.Survey

  project(%SurveyCreated{} = created, fn multi ->
    Ecto.Multi.insert(multi, :survey_created, %Survey{
      id: created.survey_id,
      user_id: created.user_id,
      title: created.title
    })
  end)

  project(%SurveyTitleUpdated{} = updated, fn multi ->
    Ecto.Multi.update_all(
      multi,
      :survey_title_updated,
      survey_query(updated.survey_id),
      set: [title: updated.title]
    )
  end)

  project(%SurveyArchived{} = updated, fn multi ->
    Ecto.Multi.update_all(
      multi,
      :survey_title_updated,
      survey_query(updated.survey_id),
      set: [archived_at: updated.archived_at]
    )
  end)

  defp survey_query(id) do
    from s in Survey,
      where: s.id == ^id
  end
end
