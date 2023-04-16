defmodule Sage.Surveys.Question do
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

    attribute :type, :atom do
      allow_nil? false
      constraints one_of: [:single, :multi, :text, :number]
    end

    timestamps()
  end

  relationships do
    belongs_to :survey, Sage.Surveys.Survey do
      private? true
    end
  end

  actions do
    defaults [:create, :read, :update, :destroy]
  end

  graphql do
    type :question

    queries do
    end

    mutations do
    end
  end

  policies do
    policy action_type(:create) do
      authorize_if actor_present()
    end

    policy action_type([:read, :update, :destroy]) do
      authorize_if ActorIsAdmin
      authorize_if relates_to_actor_via([:survey, :owner])
    end
  end

  postgres do
    table "questions"
    repo Sage.Repo
  end
end
