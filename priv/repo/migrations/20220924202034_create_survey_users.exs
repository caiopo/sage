defmodule Sage.Repo.Migrations.CreateSurveyUsers do
  use Ecto.Migration

  def change do
    create table(:survey_users, primary_key: false) do
      add :id, :binary_id, primary_key: true

      add :user_id, references(:users, type: :binary_id), null: false
      add :survey_id, :binary_id

      add :role, :string
      add :deleted_at, :utc_datetime_usec, null: true

      timestamps()
    end
  end
end
