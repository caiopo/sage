defmodule Sage.SurveysFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Sage.Surveys` context.
  """

  @doc """
  Generate a survey.
  """
  def survey_fixture(attrs \\ %{}) do
    {:ok, survey} =
      attrs
      |> Enum.into(%{
        uuid: "7488a646-e31f-11e4-aace-600308960662",
        title: "some title"
      })
      |> Sage.Surveys.create_survey()

    survey
  end

  @doc """
  Generate a question.
  """
  def question_fixture(attrs \\ %{}) do
    {:ok, question} =
      attrs
      |> Enum.into(%{
        data: %{"a" => "b", "c" => 1},
        title: "some title",
        type: :single,
        uuid: "7488a646-e31f-11e4-aace-600308960662",
        survey_id: 1
      })
      |> Sage.Surveys.create_question()

    question
  end
end
