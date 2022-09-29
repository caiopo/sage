defmodule Sage.Repo.Migrations.CreateQuestions do
  use Ecto.Migration

  def change do
    create table(:questions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :version, :integer, primary_key: true
      add :title, :text, null: false
      add :order, :integer, null: false

      add :attributes, :map

      add :survey_id, references(:surveys, with: [version: :version]), null: false

      timestamps()
    end
  end
end
