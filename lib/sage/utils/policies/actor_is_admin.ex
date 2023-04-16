defmodule Sage.Policies.ActorIsAdmin do
  use Ash.Policy.SimpleCheck

  def describe(_) do
    "actor is admin"
  end

  def match?(%Sage.Accounts.User{admin: true} = actor, context, opts) do
    IO.inspect(["actor is admin", actor, context, opts])
    true
  end

  def match?(_, _, _), do: false
end
