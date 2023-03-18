defmodule Sage.Surveys.Events.QuestionCreated do
  use Sage.Struct

  alias Sage.Surveys.QuestionTypes

  typedstruct enforce: true do
    field :question_id, UUID.formatted()
    field :survey_id, UUID.formatted()
    field :title, String.t()
    field :description, String.t()
    field :attributes, QuestionTypes.t()
  end
end
