defmodule Sage.Accounts.Projectors.User do
  use Commanded.Projections.Ecto,
    application: Sage.Commanded,
    name: "Accounts.Projectors.User",
    consistency: :strong

  alias Sage.Accounts.Events.{
    UserRegistered,
    PasswordChanged
  }

  alias Sage.Accounts.Projections.User
  alias Sage.Accounts.Queries

  project(%UserRegistered{} = event, fn multi ->
    Ecto.Multi.insert(multi, :user_registered, %User{
      id: event.user_id,
      email: event.email,
      password_hash: event.password_hash
    })
  end)

  project(%PasswordChanged{} = event, fn multi ->
    Ecto.Multi.update_all(
      multi,
      :password_changed,
      Queries.by_id(event.user_id),
      set: [password_hash: event.password_hash]
    )
  end)
end
