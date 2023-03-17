defmodule Sage.Accounts.Events.UserRegistered do
  use Sage.Struct

  typedstruct enforce: true do
    field :user_id, UUID.formatted()
    field :email, String.t()
    field :password_hash, String.t()
  end
end
