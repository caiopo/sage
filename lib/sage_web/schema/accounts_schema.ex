defmodule SageWeb.Schema.AccountsSchema do
  use SageWeb, :resolver
  alias SageWeb.Resolvers.AccountsResolver

  object :user do
    field! :id, :id
    field! :email, :string
    field! :name, :string
  end

  object :query_accounts do
    field! :viewer, :user do
      resolve &AccountsResolver.viewer/2
    end
  end

  input_object :create_user_input do
    field! :name, :string
    field! :email, :string
    field! :password, :string
  end

  input_object :login_input do
    field! :email, :string
    field! :password, :string
  end

  object :login_result do
    field! :token, :string
    field! :user, :user
  end

  object :mutation_accounts do
    field! :create_user, :login_result do
      public!()

      arg! :input, :create_user_input

      resolve &AccountsResolver.create_user/3
    end

    field! :login, :login_result do
      arg! :input, :login_input

      resolve &AccountsResolver.login/3
    end
  end
end
