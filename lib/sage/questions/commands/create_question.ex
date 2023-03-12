defmodule Sage.Questions.Commands.CreateQuestion do
  use Sage.Struct

  alias Sage.Questions.Type

  typedstruct enforce: true do
    field :survey_id, UUID.formatted()
    field :type, Type.t()
    field :attrs, map()
  end
end
