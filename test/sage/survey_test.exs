defmodule Sage.SurveysTest do
  use Sage.DataCase

  alias Sage.Surveys
  alias Sage.Surveys.Survey

  import Sage.SurveysFixtures
  import Sage.AccountsFixtures

  @invalid_attrs %{title: nil, version: nil}

  test "get_latest_survey!/1 returns the survey with given id" do
    survey = survey_fixture()
    assert Surveys.get_latest_survey!(survey.id) == survey
  end

  test "create_new_survey/1 with valid data creates a survey" do
    valid_attrs = %{title: "some title", version: 42}

    assert {:ok, %Survey{} = survey} = Surveys.create_new_survey(valid_attrs)
    assert survey.title == "some title"
    assert survey.version == 42
  end

  test "create_new_survey/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Surveys.create_new_survey(@invalid_attrs)
  end

  test "create_survey_version/2 updates survey data by creating a new version" do
    survey = survey_fixture()
    assert survey == Surveys.get_latest_survey!(survey.id)

    {:ok, new_survey} = Surveys.create_survey_version(survey.id, %{title: "My new survey title"})

    assert match?(%{title: "My new survey title", version: 2}, new_survey)
    assert survey != new_survey
    assert survey.id == new_survey.id
    assert new_survey == Surveys.get_latest_survey!(survey.id)
  end

  test "list_surveys_for_user/1 returns the latest version for all user's surveys" do
    user = user_fixture()
    survey = survey_fixture()
    Surveys.grant_survey_user_role(survey, user, :admin)

    # creating new versions for the same survey
    assert Surveys.list_surveys_for_user(user) == [Map.merge(survey, %{role: :admin})]

    assert {:ok, survey2} = Surveys.create_survey_version(survey.id, %{title: "New Title"})
    assert Surveys.list_surveys_for_user(user) == [Map.merge(survey2, %{role: :admin})]

    assert {:ok, survey3} = Surveys.create_survey_version(survey.id, %{title: "New Title Again"})
    assert Surveys.list_surveys_for_user(user) == [Map.merge(survey3, %{role: :admin})]

    Clock.advance()

    # multiple surveys
    new_survey = survey_fixture()
    Surveys.grant_survey_user_role(new_survey, user, :editor)

    assert Surveys.list_surveys_for_user(user) == [
             Map.merge(new_survey, %{role: :editor}),
             Map.merge(survey3, %{role: :admin})
           ]

    Clock.advance()

    assert {:ok, new_survey2} =
             Surveys.create_survey_version(new_survey.id, %{title: "New Title Survey 2"})

    assert Surveys.list_surveys_for_user(user) == [
             Map.merge(new_survey2, %{role: :editor}),
             Map.merge(survey3, %{role: :admin})
           ]

    Clock.advance()

    assert {:ok, survey4} =
             Surveys.create_survey_version(survey.id, %{title: "New Title Again Twice"})

    assert Surveys.list_surveys_for_user(user) == [
             Map.merge(survey4, %{role: :admin}),
             Map.merge(new_survey2, %{role: :editor})
           ]

    Clock.unfreeze()
  end
end
