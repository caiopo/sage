defmodule Sage.Utils.User do
  alias Sage.Accounts.User
  alias Sage.Accounts

  def create_user do
    User
    |> Ash.Changeset.for_create(:register_with_password,
      name: "Lorem Ipsum",
      email: "lorem@ipsum.com",
      password: "hello123",
      password_confirmation: "hello123"
    )
    |> Accounts.create!()
  end

  def login(%{conn: conn}) do
    conn = Plug.Conn.assign(conn, :current_user, create_user())
    [conn: conn]
  end
end
