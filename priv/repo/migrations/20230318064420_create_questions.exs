defmodule Sage.Repo.Migrations.CreateQuestions do
  use Ecto.Migration

  def change do
    create table(:questions, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :survey_id, :uuid, null: false
      add :title, :string, null: false
      add :description, :string, null: false
      add :attributes, :map, null: false
      add :archived_at, :utc_datetime_usec

      timestamps()
    end

    create index(:questions, [:survey_id])
  end
end
