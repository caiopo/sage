defmodule Sage.Clock do
  def utc_now do
    Process.get(:mock_utc_now) || DateTime.utc_now()
  end

  @config Application.compile_env(:sage, __MODULE__) || []

  if @config[:freezable] do
    def freeze do
      Process.put(:mock_utc_now, utc_now())
    end

    def freeze(on) do
      Process.put(:mock_utc_now, on)
    end

    def unfreeze do
      Process.delete(:mock_utc_now)
    end

    def add(amount) do
      freeze(DateTime.add(utc_now(), amount))
    end

    @doc "Advances the frozen clock by a minute"
    def advance do
      add(60)
    end

    defmacro time_travel(to, do: block) do
      quote do
        previous = Process.get(:mock_utc_now)
        Clock.freeze(unquote(to))
        result = unquote(block)
        Clock.freeze(previous)
        result
      end
    end
  end
end
