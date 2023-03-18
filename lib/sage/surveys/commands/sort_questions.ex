defmodule Sage.Surveys.Commands.SortQuestions do
  use Sage.Struct

  typedstruct enforce: true do
    field :survey_id, UUID.formatted()
    field :question_ids, nonempty_list(UUID.formatted())
  end
end
