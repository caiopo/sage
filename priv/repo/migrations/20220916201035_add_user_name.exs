defmodule Sage.Repo.Migrations.AddUserName do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :name, :string, null: false, default: "Anon"
    end
  end
end
