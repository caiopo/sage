defmodule Sage.Surveys.Events.QuestionCreated do
  use Sage.Struct

  alias Sage.Questions.Types

  typedstruct enforce: true do
    field :question_id, UUID.formatted()
    field :survey_id, UUID.formatted()
    field :attributes, Types.t()
  end
end
