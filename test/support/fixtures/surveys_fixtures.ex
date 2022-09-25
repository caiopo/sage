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
        title: "My Survey",
        version: 1
      })
      |> Sage.Surveys.create_new_survey()

    survey
  end

  @doc """
  Generate a question.
  """
  def question_fixture(attrs \\ %{}) do
    {:ok, question} =
      attrs
      |> Enum.into(%{
        order: 42,
        title: "some title",
        type: :single,
        version: 42
      })
      |> Sage.Surveys.create_question()

    question
  end
end
