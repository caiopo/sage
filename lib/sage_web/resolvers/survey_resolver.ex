defmodule SageWeb.Resolvers.Surveys do
  alias Sage.Surveys

  def list_surveys(_root, _attrs, %{context: %{current_user: current_user}}) do
    {:ok, Surveys.list_surveys_for_user(current_user)}
  end

  def list_questions(_root, %{survey_uuid: uuid}, %{context: %{current_user: current_user}}) do
    survey = Surveys.get_survey_by_uuid(uuid)

    if survey.user_id == current_user.id do
      questions = Surveys.list_survey_questions(survey)
      {:ok, questions}
    else
      {:error, "Unauthorized"}
    end
  end

  def update_survey(_root, %{survey: survey}, _) do
    survey = Surveys.create_survey(survey)
    Surveys.upsert_questions(survey, survey.questions)

    {:ok, %{title: "123", uuid: "2345"}}
  end
end
