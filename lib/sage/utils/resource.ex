defmodule Sage.Resource do
  defmacro __using__(_opts) do
    quote do
      import Sage.Resource
      alias Sage.Policies.ActorIsAdmin
    end
  end

  defmacro sage_primary_key() do
    quote do
      uuid_primary_key :id, default: &Sage.UUID.generate/0
    end
  end
end
