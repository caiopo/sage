defmodule SageWeb.Schema.AccountsSchema do
  use Absinthe.Schema.Notation

  alias SageWeb.Resolvers.AccountsResolver

  object :user do
    field :id, non_null(:id)
    field :email, non_null(:string)
  end

  object :query_user do
    field :viewer, :user do
      resolve(&AccountsResolver.get_viewer/2)
    end
  end

  object :mutation_user do
    field :create_user, :user do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))

      resolve(&AccountsResolver.create_user/3)
    end

    field :login, :user do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))

      resolve(&AccountsResolver.login/3)
    end

  end
end
