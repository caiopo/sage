defmodule Sage.Questions.Types.Text do
  use Sage.Struct

  @type text_type :: :text

  typedstruct enforce: true do
    field :type, text_type(), default: :text
    field :min_length, non_neg_integer()
    field :max_length, non_neg_integer()
  end
end
