defmodule Sage.Surveys.QuestionAnswer do
  use Ash.Resource,
    domain: Sage.Surveys,
    data_layer: AshPostgres.DataLayer,
    authorizers: [Ash.Policy.Authorizer],
    extensions: [AshArchival.Resource, AshGraphql.Resource]

  use Sage.Resource

  attributes do
    sage_primary_key()

    attribute :value, :string, public?: true

    timestamps()
  end

  relationships do
    belongs_to :survey_answer, Sage.Surveys.SurveyAnswer, allow_nil?: false, public?: true

    belongs_to :question, Sage.Surveys.Question do
      allow_nil? false
      attribute_writable? true
      public? true
    end
  end

  actions do
    defaults [:create, :read, :update, :destroy]
  end

  graphql do
    type :question_answer

    depth_limit 3

    queries do
    end

    mutations do
    end
  end

  postgres do
    table "question_answers"
    repo Sage.Repo
  end
end
