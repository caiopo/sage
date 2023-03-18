defmodule Sage.Questions.Commands.CreateQuestion do
  use Sage.Struct

  alias Sage.Questions.Types

  typedstruct enforce: true do
    # field :survey_id, UUID.formatted()
    # field :type, Types.t()
    field :attributes, Types.Numeric.t() | Types.Text.t()
  end
end
