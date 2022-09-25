defmodule Sage.Surveys do
  @moduledoc """
  The Surveys context.
  """

  import Ecto.Query, warn: false
  alias Ecto.Changeset

  alias Sage.Repo

  alias Sage.Surveys.Survey

  def list_surveys do
    Repo.all(Survey)
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
    survey = get_latest_survey!(id)

    %{survey | inserted_at: nil, updated_at: nil}
    |> Changeset.change()
    |> Survey.changeset(attrs)
    |> Changeset.put_change(:version, survey.version + 1)
    |> Repo.insert()
  end

  alias Sage.Surveys.Question

  @doc """
  Returns the list of questions.

  ## Examples

      iex> list_questions()
      [%Question{}, ...]

  """
  def list_questions do
    Repo.all(Question)
  end

  @doc """
  Gets a single question.

  Raises `Ecto.NoResultsError` if the Question does not exist.

  ## Examples

      iex> get_question!(123)
      %Question{}

      iex> get_question!(456)
      ** (Ecto.NoResultsError)

  """
  def get_question!(id), do: Repo.get!(Question, id)

  @doc """
  Creates a question.

  ## Examples

      iex> create_question(%{field: value})
      {:ok, %Question{}}

      iex> create_question(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_question(attrs \\ %{}) do
    %Question{}
    |> Question.changeset(attrs)
    |> Repo.insert()
  end

  alias Sage.Surveys.SurveyUsers

  def grant_survey_user_role(survey, user, role) do
    Repo.transaction(fn ->
      revoke_survey_user_role(survey, user)

      %SurveyUsers{}
      |> SurveyUsers.changeset(%{user: user, survey: survey, role: role})
      |> Repo.insert!()
    end)
  end

  def revoke_survey_user_role(survey, user) do
    Repo.update_all(
      query_survey_user(survey, user),
      set: [deleted_at: DateTime.utc_now()]
    )
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
