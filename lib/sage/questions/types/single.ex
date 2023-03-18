defmodule Sage.Questions.Types.Single do
  use Sage.Struct

  @type single_type :: :single

  typedstruct enforce: true do
    field :type, single_type(), default: :single
    field :options, nonempty_list(String.t())
  end
end
