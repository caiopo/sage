defmodule Sage.Accounts do
  alias Sage.Commanded
  alias Sage.Repo

  alias Sage.Accounts.Queries

  alias Sage.Accounts.Commands.{
    RegisterUser,
    ChangePassword
  }

  def register_user(email: email, password: password) do
    RegisterUser.new(
      user_id: Sage.Gen.uuid(),
      email: email,
      password: password
    )
    |> Commanded.maybe_dispatch()
  end

  def change_password(user_id: user_id, password: password) do
    ChangePassword.new(
      user_id: user_id,
      password: password
    )
    |> Commanded.maybe_dispatch()
  end

  def get_by_id!(user_id) do
    Queries.by_id(user_id)
    |> Repo.one!()
  end
end
