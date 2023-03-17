defmodule SageWeb.Resolvers.SurveysResolver do
  alias Sage.Surveys
  alias Sage.Accounts
  alias SageWeb.Adapters

  def list_surveys(_input, %{context: %{current_user: user}}) do
    surveys = Surveys.list_surveys_for_user(user)
    {:ok, surveys}
  end

  def create_survey(input, %{context: %{current_user: _user}}) do
    {:ok, nil}
  end

  def edit_survey(_input, %{context: %{current_user: _user}}) do
    {:ok, nil}
  end

  def share_survey(%{input: input}, %{context: %{current_user: user}}) do
    %{survey_id: survey_id, email: email} = input

    if Surveys.user_has_access_to_survey?(survey_id, user, :admin) do
      survey = Surveys.get_latest_survey!(survey_id)
      invited_user = Accounts.get_user_by_email(email)
      Surveys.grant_survey_user_role(survey, invited_user, :editor)
    end
  end

  def list_questions(survey, _input, %{context: %{current_user: _user}}) do
    questions =
      Surveys.list_survey_questions(survey)
      |> Enum.map(&Adapters.Questions.to_wire/1)

    {:ok, questions}
  end
end
