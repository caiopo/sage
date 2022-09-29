defmodule Sage.Surveys.QuestionType.Multi do
  use Sage.Schema
  import Ecto.Changeset

  @primary_key false

  embedded_schema do
    field :type, Ecto.Enum, values: [:multi]
    field :options, {:array, :string}
  end

  def changeset(multi, params) do
    multi
    |> cast(params, ~w(options)a)
    |> put_change(:type, :multi)
    |> validate_required(~w(type options)a)
    |> validate_length(:options, min: 1)
  end
end
