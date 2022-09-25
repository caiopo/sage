defmodule Sage.Surveys.Question do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "questions" do
    field :order, :integer
    field :title, :string
    field :type, Ecto.Enum, values: [:single, :multi, :text, :number]
    field :version, :integer

    timestamps()
  end

  @doc false
  def changeset(question, attrs) do
    question
    |> cast(attrs, [:version, :title, :type, :order])
    |> validate_required([:version, :title, :type, :order])
  end
end
