defmodule Sage.Surveys.Events.QuestionsSorted do
  use Sage.Struct

  alias Sage.Questions.Types

  typedstruct enforce: true do
    field :survey_id, UUID.formatted()
    field :question_ids, nonempty_list(UUID.formatted())
  end
end
