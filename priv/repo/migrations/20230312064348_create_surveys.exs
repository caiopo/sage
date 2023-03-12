defmodule Sage.Repo.Migrations.CreateSurveys do
  use Ecto.Migration

  def change do
    create table(:surveys, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :user_id, :uuid
      add :title, :string
      add :archived_at, :utc_datetime_usec

      timestamps()
    end

    create index(:surveys, [:user_id])
  end
end
