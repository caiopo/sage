defmodule Sage.Surveys.Projections.Question do
  use Sage.Schema

  @primary_key {:id, :binary_id, autogenerate: false}

  schema "questions" do
    field :survey_id, :binary_id
    field :title, :string
    field :description, :string
    field :attributes, :map
    field :archived_at, :utc_datetime

    timestamps()
  end
end
