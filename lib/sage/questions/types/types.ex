defmodule Sage.Questions.Types do
  @type t :: :single | :multi | :numeric | :text

  alias Sage.Questions.Types

  def from_map(%{type: :single} = map),
    do: Types.Single.new(map)

  def from_map(%{type: :multi} = map),
    do: Types.Multi.new(map)

  def from_map(%{type: :numeric} = map),
    do: Types.Numeric.new(map)

  def from_map(%{type: :text} = map),
    do: Types.Text.new(map)
end
