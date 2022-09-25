defmodule Sage.Repo.Migrations.CreateQuestions do
  use Ecto.Migration

  def change do
    create table(:questions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :version, :integer, primary_key: true
      add :title, :text
      add :type, :string
      add :order, :integer

      timestamps()
    end
  end
end
