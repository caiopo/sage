defmodule Sage.Surveys.Question do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "questions" do
    field :title, :string
    field :type, Ecto.Enum, values: [:single, :multi, :text, :number]
    field :uuid, Ecto.UUID
    field :data, :map

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
