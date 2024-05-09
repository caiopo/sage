defmodule Sage.Surveys.SurveyAnswer do
  use Ash.Resource,
    domain: Sage.Surveys,
    data_layer: AshPostgres.DataLayer,
    authorizers: [Ash.Policy.Authorizer],
    extensions: [AshArchival.Resource, AshGraphql.Resource]

  use Sage.Resource

  attributes do
    sage_primary_key()

    timestamps()
  end

  relationships do
    belongs_to :survey, Sage.Surveys.Survey, public?: true
    has_many :question_answers, Sage.Surveys.QuestionAnswer, public?: true
  end

  actions do
    defaults [:read, :destroy]

    create :create do
      argument :question_answers, {:array, :map}
      change relate_actor(:owner)
      change manage_relationship(:question_answers, type: :direct_control)
    end
  end

  graphql do
    type :survey_answer

    depth_limit 3

    queries do
      get :get_answer, :read
      list :list_answers, :read
    end

    mutations do
      create :create_answer, :create
      destroy :archive_answer, :destroy
    end

    # managed_relationships do
    #   auto? true
    # end
  end

  postgres do
    table "survey_answers"
    repo Sage.Repo
  end
end
