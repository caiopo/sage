defmodule Sage.Questions.Types.Numeric do
  use Sage.Struct

  @type numeric_type :: :numeric

  typedstruct enforce: true do
    field :type, numeric_type(), default: :numeric
    field :min, integer(), enforce: false
    field :max, integer(), enforce: false
  end

  precond(
    t: fn attrs ->
      if not is_nil(attrs.min) and not is_nil(attrs.max) and
           attrs.max < attrs.min do
        {:error, "max should be greater than min"}
      else
        :ok
      end
    end
  )
end
