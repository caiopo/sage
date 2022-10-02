defmodule Sage.QuestionTest do
  use Sage.DataCase

  alias Sage.Surveys

  alias Sage.Surveys.Question

  import Sage.SurveysFixtures

  @invalid_attrs %{order: nil, title: nil, type: nil, version: nil, survey: nil}

  test "create_question/1 with valid data creates a question" do
    valid_attrs = %{
      order: 42,
      title: "some title",
      version: 1,
      survey: survey_fixture(),
      attributes: %{
        type: :single,
        options: ["My option", "Another option"]
      }
    }

    assert {:ok, %Question{} = question} = Surveys.create_question(valid_attrs)
    assert question.order == 42
    assert question.title == "some title"
    assert question.version == 1
  end

  test "create_question/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Surveys.create_question(@invalid_attrs)
  end

  test "create_question/1 associates with the survey" do
    survey = survey_fixture()

    assert {:ok, question} =
             Surveys.create_question(%{
               order: 2,
               title: "some title",
               version: 1,
               survey: survey,
               attributes: %{
                 type: :single,
                 options: ["My option", "Another option"]
               }
             })

    assert question.survey == survey

    assert Surveys.list_survey_questions(survey) |> Repo.preload(:survey) == [question]

    assert {:ok, question2} =
             Surveys.create_question(%{
               order: 1,
               title: "other title",
               version: 1,
               survey: survey,
               attributes: %{
                 type: :multi,
                 options: ["My option", "Another option"]
               }
             })

    assert Surveys.list_survey_questions(survey) |> Repo.preload(:survey) == [
             question2,
             question
           ]
  end
end
