defmodule Sage.Surveys.Survey do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "surveys" do
    field :version, :integer, primary_key: true
    field :title, :string
    field :deleted_at, :utc_datetime_usec

    timestamps()
  end

  @doc false
  def changeset(survey, attrs) do
    survey
    |> cast(attrs, [:id, :version, :title, :deleted_at])
    |> validate_required([:version, :title])
  end
end
