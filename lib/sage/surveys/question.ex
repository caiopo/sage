defmodule Sage.Surveys.Question do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "questions" do
    field :uuid, Ecto.UUID, primary_key: true
    belongs_to :survey, Sage.Surveys.Survey, primary_key: true

    field :title, :string
    field :type, Ecto.Enum, values: [:single, :multi, :text, :number]
    field :data, :map

    timestamps()
  end

  @doc false
  def changeset(question, attrs) do
    question
    |> cast(attrs, [:uuid, :title, :type, :data])
    |> validate_required([:uuid, :title, :type, :data])
  end
end
