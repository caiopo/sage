defmodule Sage.Surveys.Commands.CreateSurvey do
  use Sage.Struct

  typedstruct enforce: true do
    field :survey_id, UUID.formatted()
    field :user_id, UUID.formatted()
    field :title, String.t()
  end
end
