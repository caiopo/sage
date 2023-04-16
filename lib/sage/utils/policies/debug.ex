defmodule Sage.Policies.Debug do
  use Ash.Policy.SimpleCheck

  def describe(_) do
    "debug"
  end

  def match?(actor, context, opts) do
    IO.inspect(["debug", actor, context, opts])
    false
  end
end
