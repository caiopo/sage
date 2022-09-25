defmodule Sage.Surveys do
  @moduledoc """
  The Surveys context.
  """

  import Ecto.Query, warn: false
  alias Ecto.Changeset

  alias Sage.Repo

  alias Sage.Accounts.User
  alias Sage.Surveys.{Survey, Question, SurveyUsers}

  def list_surveys_for_user(user) do
    q =
      from s in Survey,
        where: is_nil(s.deleted_at),
        join: su in SurveyUsers,
        on: su.survey_id == s.id,
        join: u in User,
        on: su.user_id == ^user.id,
        order_by: [desc: :inserted_at],
        select_merge: %{role: su.role}

    Repo.all(q)
  end

  def get_latest_survey!(id) do
    q =
      from s in Survey,
        where: s.id == ^id,
        order_by: [desc: :version],
        limit: 1

    Repo.one!(q)
  end

  def create_new_survey(attrs \\ %{}) do
    %Survey{}
    |> Changeset.change()
    |> Changeset.put_change(:version, 1)
    |> Survey.changeset(attrs)
    |> Repo.insert()
  end

  def create_survey_version(id, attrs \\ %{}) do
    with {:ok, new_survey} <-
           Repo.transaction(fn ->
             survey = get_latest_survey!(id)
             delete_survey(id)

             %{survey | inserted_at: nil, updated_at: nil}
             |> Changeset.change()
             |> Survey.changeset(attrs)
             |> Changeset.put_change(:version, survey.version + 1)
             |> Repo.insert()
           end) do
      new_survey
    end
  end

  def delete_survey(id) do
    Repo.update_all(
      from(s in Survey,
        where: s.id == ^id
      ),
      set: [deleted_at: DateTime.utc_now()]
    )
  end

  def list_questions do
    Repo.all(Question)
  end

  def get_question!(id), do: Repo.get!(Question, id)

  def create_question(attrs \\ %{}) do
    %Question{}
    |> Question.changeset(attrs)
    |> Repo.insert()
  end

  def grant_survey_user_role(survey, user, role) do
    Repo.transaction(fn ->
      revoke_survey_user_role(survey, user)

      %SurveyUsers{}
      |> SurveyUsers.changeset(%{user: user, survey: survey, role: role})
      |> Repo.insert!()
    end)
  end

  def revoke_survey_user_role(survey, user) do
    query_survey_user(survey, user)
    |> Repo.update_all(set: [deleted_at: DateTime.utc_now()])
  end

  def get_survey_users(survey, user) do
    query_survey_user(survey, user)
    |> Repo.one()
  end

  defp query_survey_user(survey, user) do
    from su in SurveyUsers,
      where:
        su.user_id == ^user.id and su.survey_id == ^survey.id and
          is_nil(su.deleted_at)
  end
end
