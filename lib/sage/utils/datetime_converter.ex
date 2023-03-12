defmodule Sage.Utils.DatetimeConverter do
  defmacro __using__(fields: fields) do
    quote bind_quoted: [fields: fields] do
      defimpl Commanded.Serialization.JsonDecoder, for: __MODULE__ do
        def decode(event) do
          unquote(fields)
          |> Enum.reduce(event, fn f, event ->
            value = Map.get(event, f)

            if is_nil(value) do
              event
            else
              {:ok, dt, _} = DateTime.from_iso8601(value)
              Map.put(event, f, dt)
            end
          end)
        end
      end
    end
  end
end
