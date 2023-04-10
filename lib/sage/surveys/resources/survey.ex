defmodule Sage.Surveys.Survey do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer

  actions do
    defaults [:create, :read, :update]

    update :archive do
      accept []
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :title, :string do
      allow_nil? false
    end


    timestamps
  end

  relationships do
    has_many :questions, Helpdesk.Surveys.Question
  end

  postgres do
    table "surveys"
    repo Sage.Repo
  end
end
