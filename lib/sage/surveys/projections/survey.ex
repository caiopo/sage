defmodule Sage.Surveys.Projections.Survey do
  use Sage.Schema

  @primary_key {:id, :binary_id, autogenerate: false}

  schema "surveys" do
    field :user_id, :binary_id
    field :title, :string
    field :archived_at, :utc_datetime

    timestamps()
  end
end
