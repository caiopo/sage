defmodule Sage.Accounts.Aggregates.User do
  use Sage.Struct

  typedstruct enforce: true do
    field :id, UUID.formatted(), enforce: false
    field :email, String.t()
    field :password_hash, String.t()
  end

  alias Sage.Accounts.Aggregates.User

  alias Sage.Accounts.Commands.{
    RegisterUser,
    ChangePassword
  }

  alias Sage.Accounts.Events.{
    UserRegistered,
    PasswordChanged
  }

  def execute(%User{id: nil}, %RegisterUser{} = command) do
    UserRegistered.new!(
      user_id: Sage.Gen.uuid(),
      email: command.email,
      password_hash: Sage.Passwords.hash(command.password)
    )
  end

  def execute(%User{}, %RegisterUser{}),
    do: {:error, "Cannot create user that already exists"}

  def execute(%User{id: nil}, %ChangePassword{}),
    do: {:error, "Cannot change the password of a nonexistent user"}

  def execute(%User{}, %ChangePassword{} = command) do
    PasswordChanged.new!(
      user_id: command.user_id,
      password_hash: Sage.Passwords.hash(command.password)
    )
  end

  def apply(%User{} = user, %UserRegistered{} = event) do
    %{
      user
      | id: event.user_id,
        email: event.email,
        password_hash: event.password_hash
    }
  end

  def apply(%User{} = user, %PasswordChanged{} = event) do
    %{
      user
      | password_hash: event.password_hash
    }
  end
end
