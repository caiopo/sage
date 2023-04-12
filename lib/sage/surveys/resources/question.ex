defmodule Sage.Surveys.Question do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshArchival.Resource, AshGraphql.Resource]

  attributes do
    uuid_primary_key :id

    attribute :title, :string do
      allow_nil? false
    end

    attribute :type, :atom do
      constraints one_of: [:single, :multi, :text, :number]
      allow_nil? false
    end

    timestamps()
  end

  relationships do
    belongs_to :survey, Sage.Surveys.Survey do
      attribute_writable? true
    end
  end

  actions do
    defaults [:create, :read, :update, :destroy]
  end

  graphql do
    type :question

    queries do
      # get :get_question, :read
      # list :list_questions, :for_survey
    end

    mutations do
      create :create_question, :create
      update :update_question, :update
      destroy :archive_question, :destroy
    end
  end
  postgres do
    table "questions"
    repo Sage.Repo
  end
end
