defmodule Sage.SurveysTest do
  use Sage.DataCase

  alias Sage.Surveys

  describe "surveys" do
    alias Sage.Surveys.Survey

    import Sage.SurveysFixtures

    @invalid_attrs %{title: nil, uuid: nil}

    test "list_surveys/0 returns all surveys" do
      survey = survey_fixture()
      assert Surveys.list_surveys() == [survey]
    end

    test "get_survey!/1 returns the survey with given id" do
      survey = survey_fixture()
      assert Surveys.get_survey!(survey.id) == survey
    end

    test "create_survey/1 with valid data creates a survey" do
      valid_attrs = %{title: "some title", uuid: "7488a646-e31f-11e4-aace-600308960662"}

      assert {:ok, %Survey{} = survey} = Surveys.create_survey(valid_attrs)
      assert survey.title == "some title"
      assert survey.uuid == "7488a646-e31f-11e4-aace-600308960662"
    end

    test "create_survey/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Surveys.create_survey(@invalid_attrs)
    end

    test "update_survey/2 with valid data updates the survey" do
      survey = survey_fixture()
      update_attrs = %{title: "some updated title", uuid: "7488a646-e31f-11e4-aace-600308960668"}

      assert {:ok, %Survey{} = survey} = Surveys.update_survey(survey, update_attrs)
      assert survey.title == "some updated title"
      assert survey.uuid == "7488a646-e31f-11e4-aace-600308960668"
    end

    test "update_survey/2 with invalid data returns error changeset" do
      survey = survey_fixture()
      assert {:error, %Ecto.Changeset{}} = Surveys.update_survey(survey, @invalid_attrs)
      assert survey == Surveys.get_survey!(survey.id)
    end

    test "delete_survey/1 deletes the survey" do
      survey = survey_fixture()
      assert {:ok, %Survey{}} = Surveys.delete_survey(survey)
      assert_raise Ecto.NoResultsError, fn -> Surveys.get_survey!(survey.id) end
    end

    test "change_survey/1 returns a survey changeset" do
      survey = survey_fixture()
      assert %Ecto.Changeset{} = Surveys.change_survey(survey)
    end
  end

  describe "questions" do
    alias Sage.Surveys.Question

    import Sage.SurveysFixtures

    @invalid_attrs %{data: nil, title: nil, type: nil, uuid: nil}

    test "list_questions/0 returns all questions" do
      question = question_fixture()
      assert Surveys.list_questions() == [question]
    end

    test "get_question!/1 returns the question with given id" do
      question = question_fixture()
      assert Surveys.get_question!(question.id) == question
    end

    test "create_question/1 with valid data creates a question" do
      valid_attrs = %{
        data: %{},
        title: "some title",
        type: :single,
        uuid: "7488a646-e31f-11e4-aace-600308960662"
      }

      assert {:ok, %Question{} = question} = Surveys.create_question(valid_attrs)
      assert question.data == %{}
      assert question.title == "some title"
      assert question.type == :single
      assert question.uuid == "7488a646-e31f-11e4-aace-600308960662"
    end

    test "create_question/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Surveys.create_question(@invalid_attrs)
    end

    test "update_question/2 with valid data updates the question" do
      question = question_fixture()

      update_attrs = %{
        data: %{},
        title: "some updated title",
        type: :multi,
        uuid: "7488a646-e31f-11e4-aace-600308960668"
      }

      assert {:ok, %Question{} = question} = Surveys.update_question(question, update_attrs)
      assert question.data == %{}
      assert question.title == "some updated title"
      assert question.type == :multi
      assert question.uuid == "7488a646-e31f-11e4-aace-600308960668"
    end

    test "update_question/2 with invalid data returns error changeset" do
      question = question_fixture()
      assert {:error, %Ecto.Changeset{}} = Surveys.update_question(question, @invalid_attrs)
      assert question == Surveys.get_question!(question.id)
    end

    test "delete_question/1 deletes the question" do
      question = question_fixture()
      assert {:ok, %Question{}} = Surveys.delete_question(question)
      assert_raise Ecto.NoResultsError, fn -> Surveys.get_question!(question.id) end
    end

    test "change_question/1 returns a question changeset" do
      question = question_fixture()
      assert %Ecto.Changeset{} = Surveys.change_question(question)
    end
  end
end
