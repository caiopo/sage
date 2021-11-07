defmodule Sage.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :name, :string
    field :picture, :string
    field :uid, :string

    has_many :surveys, Sage.Surveys.Survey

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:uid, :name, :email, :picture])
    |> validate_required([:uid, :name, :email, :picture])
  end
end
