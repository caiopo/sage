defmodule Sage.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :uid, :string
      add :name, :text
      add :email, :text
      add :picture, :text

      timestamps()
    end
  end
end
