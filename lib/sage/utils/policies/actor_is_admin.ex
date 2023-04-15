defmodule Sage.Policies.ActorIsAdmin do
  use Ash.Policy.SimpleCheck

  def describe(_) do
    "actor is admin"
  end

  def match?(%Sage.Accounts.User{admin: true} = _actor, _context, _opts) do
    IO.inspect(["actor is admin", _actor, _context])
    true
  end

  def match?(_, _, _), do: false
end
