defmodule Sage.Surveys.Survey do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    authorizers: [Ash.Policy.Authorizer],
    extensions: [AshArchival.Resource, AshGraphql.Resource]

  use Sage.Resource

  attributes do
    sage_primary_key()

    attribute :title, :string do
      allow_nil? false
    end

    timestamps()
  end

  relationships do
    belongs_to :owner, Sage.Accounts.User do
      api Sage.Accounts
      allow_nil? false
    end
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

  policies do
    policy action_type(:read) do
      authorize_if relates_to_actor_via(:owner)
    end
  end

  policies do
    policy always() do
      authorize_if AdminActor
    end
  end

  postgres do
    table "surveys"
    repo Sage.Repo
  end
end
