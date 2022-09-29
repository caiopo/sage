defmodule Sage.Surveys.QuestionType.Number do
  use Sage.Schema
  import Ecto.Changeset

  @primary_key false

  embedded_schema do
    field :type, Ecto.Enum, values: [:number]
    field :min_value, :integer
    field :max_value, :integer
  end

  def changeset(number, params) do
    number
    |> cast(params, ~w(min_value max_value)a)
    |> put_change(:type, :number)
  end
end
