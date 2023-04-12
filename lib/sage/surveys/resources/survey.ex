defmodule Sage.Surveys.Survey do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshArchival.Resource, AshGraphql.Resource]

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

  actions do
    defaults [:create, :read, :update, :destroy]
  end

  graphql do
    type :survey

    queries do
      get :get_survey, :read
      list :list_surveys, :read
    end

    mutations do
      create :create_survey, :create
      update :update_survey, :update
      destroy :archive_survey, :destroy
    end
  end

  postgres do
    table "surveys"
    repo Sage.Repo
  end
end
