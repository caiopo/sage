defmodule Sage.Surveys do
  alias Sage.Commanded
  alias Sage.Repo

  alias Sage.Surveys.Commands.{
    CreateSurvey,
    ArchiveSurvey,
    UpdateSurveyTitle,
    CreateQuestion,
    SortQuestions
  }

  alias Sage.Surveys.Queries

  import ShorterMaps

  def create_survey(%{user_id: user_id, title: title}) do
    CreateSurvey.new(
      survey_id: Sage.Gen.uuid(),
      user_id: user_id,
      title: title
    )
    |> Commanded.maybe_dispatch()
  end

  def update_survey_title(%{survey_id: survey_id, title: title}) do
    UpdateSurveyTitle.new(
      survey_id: survey_id,
      title: title
    )
    |> Commanded.maybe_dispatch()
  end

  def archive_survey(%{survey_id: survey_id}) do
    ArchiveSurvey.new(
      survey_id: survey_id,
      archived_at: Sage.Clock.utc_now()
    )
    |> Commanded.maybe_dispatch()
  end

  def create_question(params) do
    CreateQuestion.new(
     Map.put(params, :question_id, Sage.Gen.uuid())
      )
    |> Commanded.maybe_dispatch()
  end

  def get_by_id!(survey_id) do
    Queries.by_id(survey_id)
    |> Repo.one!()
  end

  def get_questions_by_id!(survey_id) do
    Queries.questions_by_id(survey_id)
    |> Repo.all()
  end
end
