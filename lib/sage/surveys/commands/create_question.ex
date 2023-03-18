defmodule Sage.Surveys.Commands.CreateQuestion do
  use Sage.Struct

  alias Sage.Questions.Types

  typedstruct enforce: true do
    field :survey_id, UUID.formatted()
    field :question_id, UUID.formatted()
    field :title, String.t()
    field :description, String.t()
    field :attributes, Types.t()
  end
end
