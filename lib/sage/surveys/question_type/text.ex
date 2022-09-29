defmodule Sage.Surveys.QuestionType.Text do
  use Sage.Schema
  import Ecto.Changeset

  @primary_key false

  embedded_schema do
    field :type, Ecto.Enum, values: [:text]
    field :min_length, :integer
    field :max_length, :integer
  end

  def changeset(text, params) do
    text
    |> cast(params, ~w(min_length max_length)a)
    |> put_change(:type, :text)
    |> validate_number(:min_length, greater_than: 0)
    |> validate_number(:max_length, greater_than: 0)
  end
end
