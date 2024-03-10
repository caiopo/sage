defmodule Sage.Repo.Migrations.AddAnswerTables do
  @moduledoc """
  Updates resources based on their most recent snapshots.

  This file was autogenerated with `mix ash_postgres.generate_migrations`
  """

  use Ecto.Migration

  def up do
    create table(:survey_answers, primary_key: false) do
      add :archived_at, :utc_datetime_usec
      add :id, :uuid, null: false, primary_key: true
      add :inserted_at, :utc_datetime_usec, null: false, default: fragment("now()")
      add :updated_at, :utc_datetime_usec, null: false, default: fragment("now()")

      add :survey_id,
          references(:surveys,
            column: :id,
            name: "survey_answers_survey_id_fkey",
            type: :uuid,
            prefix: "public"
          )
    end

    create table(:question_answers, primary_key: false) do
      add :archived_at, :utc_datetime_usec
      add :id, :uuid, null: false, primary_key: true
      add :value, :text
      add :inserted_at, :utc_datetime_usec, null: false, default: fragment("now()")
      add :updated_at, :utc_datetime_usec, null: false, default: fragment("now()")

      add :survey_answer_id,
          references(:survey_answers,
            column: :id,
            name: "question_answers_survey_answer_id_fkey",
            type: :uuid,
            prefix: "public"
          )

      add :question_id,
          references(:questions,
            column: :id,
            name: "question_answers_question_id_fkey",
            type: :uuid,
            prefix: "public"
          )
    end
  end

  def down do
    drop constraint(:question_answers, "question_answers_survey_answer_id_fkey")

    drop constraint(:question_answers, "question_answers_question_id_fkey")

    drop table(:question_answers)

    drop constraint(:survey_answers, "survey_answers_survey_id_fkey")

    drop table(:survey_answers)
  end
end
