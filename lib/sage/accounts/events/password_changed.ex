defmodule Sage.Accounts.Events.PasswordChanged do
  use Sage.Struct

  typedstruct enforce: true do
    field :user_id, UUID.formatted()
    field :password_hash, String.t()
  end
end
