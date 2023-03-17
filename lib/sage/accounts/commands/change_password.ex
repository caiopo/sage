defmodule Sage.Accounts.Commands.ChangePassword do
  use Sage.Struct

  @derive {Inspect, except: [:password]}

  typedstruct enforce: true do
    field :user_id, UUID.formatted()
    field :password, String.t()
  end

  precond(
    t: fn event ->
      if not Validators.Password.valid?(event.password) do
        {:error, "invalid password"}
      else
        :ok
      end
    end
  )
end
