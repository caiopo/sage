defmodule Sage.Surveys.Question do
  use Sage.Schema
  import Ecto.Changeset
  import PolymorphicEmbed

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "questions" do
    field :order, :integer
    field :title, :string
    field :version, :integer

    belongs_to :survey, Sage.Surveys.Survey, primary_key: [:id, :version]

    polymorphic_embeds_one(:attributes,
      types: [
        single: Sage.Surveys.QuestionType.Single,
        multi: Sage.Surveys.QuestionType.Multi,
        text: Sage.Surveys.QuestionType.Text,
        number: Sage.Surveys.QuestionType.Number
      ],
      type_field: :type,
      on_type_not_found: :raise,
      on_replace: :update
    )

    timestamps()
  end

  @doc false
  def changeset(question, attrs) do
    question
    |> cast(attrs, [:title, :order])
    |> cast_polymorphic_embed(:attributes, required: true)
    |> validate_required([:title, :order])
    |> put_assoc(:survey, attrs.survey)
    |> put_change(:version, Map.get(attrs.survey || %{}, :version))
    |> foreign_key_constraint(:survey)
  end
end
