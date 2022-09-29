defmodule Sage.Repo.Migrations.CreateSurveys do
  use Ecto.Migration

  def change do
    create table(:surveys, primary_key: false) do
      add :id, :binary_id, primary_key: true, null: false
      add :version, :integer, primary_key: true, null: false
      add :title, :string, null: false
      add :deleted_at, :utc_datetime_usec, null: true

      timestamps()
    end
  end
end
