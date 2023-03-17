defmodule Sage.Accounts.Projections.User do
  use Sage.Schema

  @primary_key {:id, :binary_id, autogenerate: false}

  schema "users" do
    field :email, :string
    field :password_hash, :string

    timestamps()
  end
end
