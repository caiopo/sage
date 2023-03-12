defmodule Sage.Support.Commanded do
  alias Commanded.EventStore.EventData

  def append_events(stream_id, events) do
    Commanded.EventStore.append_to_stream(
      Sage.Commanded,
      stream_id,
      :any_version,
      Enum.map(events, &wrap_event/1)
    )
  end

  defp wrap_event(%module{} = event) do
    %EventData{
      event_type: module |> to_string,
      data: event,
      metadata: %{}
    }
  end
end
