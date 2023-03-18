defmodule Sage.Questions.Types.Multi do
  use Sage.Struct

  @type multi_type :: :multi

  typedstruct enforce: true do
    field :type, multi_type(), default: :multi
    field :options, nonempty_list(String.t())
  end
end
