defmodule Sage.Surveys.SurveyUsers do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "survey_users" do
    belongs_to :user, Sage.Accounts.User
    belongs_to :survey, Sage.Surveys.Survey, references: :id

    field :role, Ecto.Enum, values: [:admin, :editor, :user]

    field :deleted_at, :utc_datetime_usec

    timestamps()
  end

  @doc false
  def changeset(survey_users, attrs) do
    survey_users
    |> cast(attrs, [:role, :deleted_at])
    |> put_assoc(:user, attrs.user)
    |> put_assoc(:survey, attrs.survey)
    |> validate_required([])
  end
end
