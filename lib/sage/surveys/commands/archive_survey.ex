defmodule Sage.Surveys.Commands.ArchiveSurvey do
  use Sage.Struct

  typedstruct enforce: true do
    field :survey_id, UUID.formatted()
  end
end
