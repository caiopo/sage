defmodule Sage.DefaultLifespan do
  @behaviour Commanded.Aggregates.AggregateLifespan

  def after_event(_event), do: :timer.minutes(5)

  def after_command(_command), do: :timer.minutes(5)

  def after_error(_error), do: :timer.minutes(5)
end
