defmodule Sage.Accounts.Events.PasswordChanged do
  use Sage.Struct

  @derive {Inspect, except: [:password_hash]}

  typedstruct enforce: true do
    field :user_id, UUID.formatted()
    field :password_hash, String.t()
  end
end
