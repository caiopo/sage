defmodule Sage.QuestionTest do
  use Sage.DataCase

  alias Sage.Surveys

  alias Sage.Surveys.Question

  import Sage.SurveysFixtures

  @invalid_attrs %{order: nil, title: nil, type: nil, version: nil}

  test "list_questions/0 returns all questions" do
    question = question_fixture()
    assert Surveys.list_questions() == [question]
  end

  test "get_question!/1 returns the question with given id" do
    question = question_fixture()
    assert Surveys.get_question!(question.id) == question
  end

  test "create_question/1 with valid data creates a question" do
    valid_attrs = %{order: 42, title: "some title", type: :single, version: 42}

    assert {:ok, %Question{} = question} = Surveys.create_question(valid_attrs)
    assert question.order == 42
    assert question.title == "some title"
    assert question.type == :single
    assert question.version == 42
  end

  test "create_question/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Surveys.create_question(@invalid_attrs)
  end
end
