defmodule Sage.Surveys.Question do
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

    attribute :type, :atom do
      constraints one_of: [:single, :multi, :text, :number]
      allow_nil? false
    end

    timestamps
  end

  relationships do
    belongs_to :survey, Sage.Surveys.Survey
  end

  postgres do
    table "questions"
    repo Sage.Repo
  end
end
