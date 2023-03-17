defmodule Sage.Accounts.Commands.RegisterUser do
  use Sage.Struct

  typedstruct enforce: true do
    field :user_id, UUID.formatted()
    field :email, String.t()
    field :password, String.t()
  end

  precond(
    t: fn event ->
      cond do
        not Sage.Validators.Email.valid?(event.email) ->
          {:error, "Invalid email"}

        not Validators.Password.valid?(event.password) ->
          {:error, "Invalid password"}

        true ->
          :ok
      end
    end
  )
end
