defmodule Sage.Surveys.Survey do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    authorizers: [Ash.Policy.Authorizer],
    extensions: [AshArchival.Resource, AshGraphql.Resource]

  use Sage.Resource

  attributes do
    sage_primary_key()

    attribute :title, :string, allow_nil?: false

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
    defaults [:read, :destroy]

    create :create do
      argument :questions, {:array, :map}
      change relate_actor(:owner)
      change manage_relationship(:questions, type: :direct_control)
    end

    update :update do
      argument :questions, {:array, :map}
      change manage_relationship(:questions, type: :direct_control)
    end
  end

  graphql do
    type :survey

    depth_limit 3

    queries do
      get :get_survey, :read
      list :list_surveys, :read
    end

    mutations do
      create :create_survey, :create
      update :update_survey, :update
      destroy :archive_survey, :destroy
    end

    managed_relationships do
      managed_relationship :create, :questions
      managed_relationship :update, :questions
    end
  end

  policies do
    policy action_type(:create) do
      authorize_if actor_present()
    end

    policy action_type([:read, :update, :destroy]) do
      authorize_if ActorIsAdmin
      authorize_if relates_to_actor_via(:owner)
    end
  end

  postgres do
    table "surveys"
    repo Sage.Repo
  end
end
