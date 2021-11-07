defmodule SageWeb.Schema.User do
  use Absinthe.Schema.Notation

  alias SageWeb.Resolvers

  object :user do
    field :uid, non_null(:string)
    field :name, non_null(:string)
    field :email, non_null(:string)
    field :picture, non_null(:string)
  end

  object :user_queries do
    @desc "Get current user"
    field :current_user, non_null(:user) do
      resolve(&Resolvers.Users.get_current_user/3)
    end
  end
end
