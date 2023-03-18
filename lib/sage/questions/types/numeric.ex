defmodule Sage.Questions.Types.Numeric do
  use Sage.Struct

  @type numeric_type :: :numeric

  typedstruct enforce: true do
    field :type, numeric_type(), default: :numeric
    field :min, integer(), enforce: false
    field :max, integer(), enforce: false
  end
end
