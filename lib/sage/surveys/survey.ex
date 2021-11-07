defmodule Sage.Surveys.Survey do
  use Ecto.Schema
  import Ecto.Changeset

  schema "surveys" do
    field :title, :string
    field :uuid, Ecto.UUID

    belongs_to :user, Sage.Accounts.User

    has_many :surveys, Sage.Surveys.Survey

    timestamps()
  end

  @doc false
  def changeset(survey, attrs) do
    survey
    |> cast(attrs, [:uuid, :title])
    |> validate_required([:uuid, :title])
  end
end
