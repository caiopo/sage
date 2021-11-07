defmodule Sage.Surveys.Question do
  use Ecto.Schema
  import Ecto.Changeset

  schema "questions" do
    field :data, :map
    field :title, :string
    field :type, Ecto.Enum, values: [:single, :multi, :text, :number]
    field :uuid, Ecto.UUID

    belongs_to :survey, Sage.Surveys.Survey

    timestamps()
  end

  @doc false
  def changeset(question, attrs) do
    question
    |> cast(attrs, [:uuid, :title, :type, :data])
    |> validate_required([:uuid, :title, :type, :data])
  end
end
