defmodule Sage.Repo.Migrations.AddSurveysAndQuestions do
  @moduledoc """
  Updates resources based on their most recent snapshots.

  This file was autogenerated with `mix ash_postgres.generate_migrations`
  """

  use Ecto.Migration

  def up do
    create table(:surveys, primary_key: false) do
      add :archived_at, :utc_datetime_usec
      add :id, :uuid, null: false, primary_key: true
      add :title, :text, null: false
      add :inserted_at, :utc_datetime_usec, null: false, default: fragment("now()")
      add :updated_at, :utc_datetime_usec, null: false, default: fragment("now()")
    end

    create table(:questions, primary_key: false) do
      add :archived_at, :utc_datetime_usec
      add :id, :uuid, null: false, primary_key: true
      add :title, :text, null: false
      add :type, :text, null: false
      add :inserted_at, :utc_datetime_usec, null: false, default: fragment("now()")
      add :updated_at, :utc_datetime_usec, null: false, default: fragment("now()")

      add :survey_id,
          references(:surveys,
            column: :id,
            name: "questions_survey_id_fkey",
            type: :uuid,
            prefix: "public"
          )
    end
  end

  def down do
    drop constraint(:questions, "questions_survey_id_fkey")

    drop table(:questions)

    drop table(:surveys)
  end
end
