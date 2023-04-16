defmodule Sage.Accounts.User do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    authorizers: [Ash.Policy.Authorizer],
    extensions: [
      AshAuthentication,
      AshArchival.Resource,
      AshGraphql.Resource
    ]

  use Sage.Resource

  attributes do
    sage_primary_key()

    attribute :email, :string, allow_nil?: false

    attribute :name, :string, allow_nil?: false

    attribute :hashed_password, :string do
      allow_nil? false
      sensitive? true
      private? true
    end

    attribute :admin, :boolean do
      allow_nil? false
      default false
      private? true
    end

    timestamps()
  end

  actions do
    defaults [:read]
  end

  identities do
    identity :unique_email, [:email]
  end

  authentication do
    api Sage.Accounts

    strategies do
      password :password do
        identity_field :email
        register_action_accept [:name]
      end
    end

    tokens do
      enabled? true
      token_resource Sage.Accounts.Token

      signing_secret fn _, _ ->
        Application.fetch_env(:sage, :token_signing_secret)
      end
    end
  end

  graphql do
    type :user

    depth_limit 3

    queries do
      get :sign_in_with_password, :sign_in_with_password do
        type_name :user_with_token
        as_mutation? true
        identity false
      end
    end

    mutations do
      create :register_with_password, :register_with_password
    end
  end

  policies do
    bypass AshAuthentication.Checks.AshAuthenticationInteraction do
      authorize_if always()
    end

    policy action(:register_with_password) do
      authorize_if always()
    end

    policy action_type(:read) do
      authorize_if action(:sign_in_with_password)
      authorize_if expr(id == ^actor(:id))
    end
  end

  postgres do
    table "users"
    repo Sage.Repo
  end
end
