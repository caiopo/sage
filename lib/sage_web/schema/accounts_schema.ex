defmodule SageWeb.Schema.AccountsSchema do
  use SageWeb, :resolver
  alias SageWeb.Resolvers.AccountsResolver

  object :user do
    field! :id, :id
    field! :email, :string
  end

  object :query_accounts do
    field! :viewer, :user do
      resolve &AccountsResolver.get_viewer/2
    end

    field! :user, :user do
      arg! :id, :id
      resolve &AccountsResolver.get_user/3
    end
  end

  input_object :create_user_input do
    field! :email, :string
    field! :name, :string
    field! :password, :string
  end

  input_object :login_input do
    field! :email, :string
    field! :name, :string
    field! :password, :string
  end

  object :mutation_accounts do
    field! :create_user, :user do
      arg! :input, :create_user_input

      resolve &AccountsResolver.create_user/3
    end

    field! :login, :user do
      arg! :input, :login_input

      resolve &AccountsResolver.login/3
    end
  end
end
