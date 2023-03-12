defmodule Sage.Surveys.Events.SurveyArchived do
  use Sage.Struct

  typedstruct enforce: true do
    field :survey_id, UUID.formatted()
    field :archived_at, DateTime.t()
  end

  use Sage.Utils.DatetimeConverter,
    fields: [:archived_at]
end
