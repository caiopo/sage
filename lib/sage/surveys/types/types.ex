defmodule Sage.Surveys.QuestionTypes do
  alias Sage.Surveys.QuestionTypes

  @type t ::
          QuestionTypes.Single.t()
          | QuestionTypes.Multi.t()
          | QuestionTypes.Numeric.t()
          | QuestionTypes.Text.t()

  def from_map(%{type: :single} = map),
    do: QuestionTypes.Single.new(map)

  def from_map(%{type: :multi} = map),
    do: QuestionTypes.Multi.new(map)

  def from_map(%{type: :numeric} = map),
    do: QuestionTypes.Numeric.new(map)

  def from_map(%{type: :text} = map),
    do: QuestionTypes.Text.new(map)

  def from_map!(params) do
    case from_map(params) do
      {:ok, value} -> value
      {:err, error} -> raise error
    end
  end
end
