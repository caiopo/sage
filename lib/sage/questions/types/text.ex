defmodule Sage.Questions.Types.Text do
  use Sage.Struct

  @type text_type :: :text

  typedstruct enforce: true do
    field :type, text_type(), default: :text
    field :min_length, non_neg_integer()
    field :max_length, non_neg_integer()
  end

  precond(
    t: fn attrs ->
      if not is_nil(attrs.min_length) and not is_nil(attrs.max_length) and
           attrs.max_length < attrs.min_length do
        {:error, "max_length should be greater than min_length"}
      else
        :ok
      end
    end
  )
end
