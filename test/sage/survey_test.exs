defmodule Sage.SurveysTest do
  use Sage.DataCase

  alias Sage.Surveys
  alias Sage.Surveys.Survey

  import Sage.SurveysFixtures

  @invalid_attrs %{title: nil, version: nil}

  test "list_surveys/0 returns all surveys" do
    survey = survey_fixture()
    assert Surveys.list_surveys() == [survey]

    other_survey = survey_fixture()
    assert Surveys.list_surveys() == [survey, other_survey]
  end

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
end
