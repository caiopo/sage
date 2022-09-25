defmodule Sage.Schema do
  defmacro __using__(_) do
    quote do
      use Ecto.Schema

      @timestamps_opts [
        autogenerate: {Sage.Clock, :utc_now, []},
        type: :utc_datetime_usec
      ]
    end
  end
end
