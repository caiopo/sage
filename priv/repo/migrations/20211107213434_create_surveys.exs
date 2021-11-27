defmodule Sage.Repo.Migrations.CreateSurveys do
  use Ecto.Migration

  def change do
    create table(:surveys) do
      add :uuid, :uuid
      add :title, :text
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:surveys, [:uuid], unique: true)
    create index(:surveys, [:user_id])
  end
end
