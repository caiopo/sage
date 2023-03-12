defmodule Sage.Surveys.SurveysTest do
  use Sage.DataCase

  import Commanded.Assertions.EventAssertions

  alias Sage.Surveys
  alias Sage.Surveys.Projections.Survey
  alias Sage.Surveys.Events.{SurveyCreated, SurveyTitleUpdated, SurveyArchived}

  describe "create survey" do
    test "publishes a SurveyCreated" do
      user_id = Sage.Gen.uuid()

      {:ok, state} =
        Surveys.create_survey(%{
          user_id: user_id,
          title: "My survey"
        })

      %{id: survey_id} = state

      # assert produced events
      assert_receive_event(Sage.Commanded, SurveyCreated, fn event ->
        assert event.survey_id == state.id
        assert event.user_id == user_id
        assert event.title == "My survey"
      end)

      # assert aggregate state
      assert {:ok, _} = Uniq.UUID.info(state.id)
      assert state.user_id == user_id
      assert state.title == "My survey"
      assert is_nil(state.archived_at)

      # assert projected entity
      projected = Surveys.get_by_id!(survey_id)
      assert projected.id == survey_id
      assert projected.user_id == user_id
      assert projected.title == "My survey"
      assert is_nil(projected.archived_at)
    end

    test "does not publishes a SurveyCreated when validation fails" do
      user_id = Sage.Gen.uuid()

      all_surveys = Repo.all(Survey)

      refute_receive_event(Sage.Commanded, SurveyCreated, fn ->
        {:error, _} =
          Surveys.create_survey(%{
            user_id: user_id,
            title: 1234
          })

        {:error, _} =
          Surveys.create_survey(%{
            user_id: "teste",
            title: "Hello world"
          })
      end)

      # assert no new survey was projected
      assert all_surveys == Repo.all(Survey)
    end
  end

  describe "update survey title" do
    test "publishes a SurveyTitleUpdated" do
      user_id = Sage.Gen.uuid()

      {:ok, %{id: survey_id}} =
        Surveys.create_survey(%{
          user_id: user_id,
          title: "My survey"
        })

      {:ok, _} =
        Surveys.update_survey_title(%{
          survey_id: survey_id,
          title: "My new survey"
        })

      assert_receive_event(Sage.Commanded, SurveyTitleUpdated, fn event ->
        assert event.survey_id == survey_id
        assert event.title == "My new survey"
      end)

      projected = Surveys.get_by_id!(survey_id)
      assert projected.title == "My new survey"
    end

    test "does not publishes a SurveyTitleUpdated when validation fails" do
      user_id = Sage.Gen.uuid()

      {:ok, state} =
        Surveys.create_survey(%{
          user_id: user_id,
          title: "My survey"
        })

      refute_receive_event(Sage.Commanded, SurveyTitleUpdated, fn ->
        {:error, _} =
          Surveys.update_survey_title(%{
            survey_id: state.id,
            title: 1234
          })

        {:error, _} =
          Surveys.update_survey_title(%{
            survey_id: "teste",
            title: "Hello world"
          })
      end)

      projected = Surveys.get_by_id!(state.id)
      assert projected.title == "My survey"
    end
  end

  describe "archive survey" do
    test "publishes a SurveyArchived" do
      user_id = Sage.Gen.uuid()
      datetime = ~U[2023-01-01 00:00:00Z]

      {:ok, %{id: survey_id}} =
        Surveys.create_survey(%{
          user_id: user_id,
          title: "My survey"
        })

      Clock.time_travel datetime do
        {:ok, _} =
          Surveys.archive_survey(%{
            survey_id: survey_id
          })
      end

      assert_receive_event(Sage.Commanded, SurveyArchived, fn event ->
        assert event.survey_id == survey_id
        assert event.archived_at == datetime
      end)

      projected = Surveys.get_by_id!(survey_id)
      assert projected.archived_at == datetime
    end

    test "does not publishes a SurveyTitleUpdated when validation fails" do
      user_id = Sage.Gen.uuid()

      {:ok, %{id: survey_id}} =
        Surveys.create_survey(%{
          user_id: user_id,
          title: "My survey"
        })

      refute_receive_event(Sage.Commanded, SurveyTitleUpdated, fn ->
        {:error, _} =
          Surveys.update_survey_title(%{
            survey_id: survey_id,
            title: 1234
          })

        {:error, _} =
          Surveys.update_survey_title(%{
            survey_id: "teste",
            title: "Hello world"
          })
      end)

      projected = Surveys.get_by_id!(survey_id)
      assert projected.title == "My survey"
    end
  end
end
