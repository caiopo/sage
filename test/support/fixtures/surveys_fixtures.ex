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
  def question_fixture(type, attrs \\ %{}) do
    {:ok, question} =
      attrs
      |> Enum.into(%{
        order: 42,
        title: "Some question",
        version: 1,
        attributes: question_attributes_fixture(type)
      })
      |> Sage.Surveys.create_question()

    question
  end

  def question_attributes_fixture(type, attrs \\ %{})

  def question_attributes_fixture(:single, attrs),
    do:
      Map.merge(
        %{
          type: :single,
          options: ~w(Red Blue Green)
        },
        attrs
      )

  def question_attributes_fixture(:multi, attrs),
    do:
      Map.merge(
        %{
          type: :multi,
          options: ~w(Apple Banana Guava)
        },
        attrs
      )

  def question_attributes_fixture(:text, attrs),
    do:
      Map.merge(
        %{
          type: :text,
          min_length: 10,
          max_length: 20
        },
        attrs
      )

  def question_attributes_fixture(:number, attrs),
    do:
      Map.merge(
        %{
          type: :number,
          min_value: 10,
          max_value: 20
        },
        attrs
      )
end
