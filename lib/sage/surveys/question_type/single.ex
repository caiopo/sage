defmodule Sage.Surveys.QuestionType.Single do
  use Sage.Schema
  import Ecto.Changeset

  @primary_key false

  embedded_schema do
    field :type, Ecto.Enum, values: [:single]
    field :options, {:array, :string}
  end

  def changeset(single, params) do
    single
    |> cast(params, ~w(options)a)
    |> put_change(:type, :single)
    |> validate_required(~w(type options)a)
    |> validate_length(:options, min: 1)
  end
end
