defmodule Sage.Repo.Migrations.CreateQuestions do
  use Ecto.Migration

  def change do
    create table(:questions, primary_key: false) do
      add :survey_id, references(:surveys, on_delete: :nothing), primary_key: true
      add :uuid, :uuid, primary_key: true

      add :title, :text
      add :type, :string
      add :data, :map

      timestamps()
    end

    create index(:questions, [:survey_id])
  end
end
