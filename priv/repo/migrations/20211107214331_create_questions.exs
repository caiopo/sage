defmodule Sage.Repo.Migrations.CreateQuestions do
  use Ecto.Migration

  def change do
    create table(:questions) do
      add :uuid, :uuid
      add :title, :text
      add :type, :string
      add :data, :map
      add :survey_id, references(:surveys, on_delete: :nothing)

      timestamps()
    end

    create index(:questions, [:survey_id])
  end
end
