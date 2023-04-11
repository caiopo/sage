defmodule Sage.Surveys.Survey do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshArchival.Resource]

  actions do
    defaults [:create, :read, :update, :destroy]
  end

  attributes do
    uuid_primary_key :id

    attribute :title, :string do
      allow_nil? false
    end

    timestamps()
  end

  relationships do
    has_many :questions, Sage.Surveys.Question
  end

  postgres do
    table "surveys"
    repo Sage.Repo
  end
end
