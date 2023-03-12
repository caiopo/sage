defmodule Sage.Surveys.Commands.UpdateSurveyTitle do
  use Sage.Struct

  typedstruct enforce: true do
    field :survey_id, UUID.formatted()
    field :title, String.t()
  end
end
