defmodule SageWeb.Schema.User do
  use Absinthe.Schema.Notation

  alias SageWeb.Resolvers
  alias Sage.Accounts.User

  object :user do
    field :uid, non_null(:string)
    field :name, non_null(:string)
    field :email, non_null(:string)
    field :picture, non_null(:string)
  end

  object :user_queries do
    @desc "Get current user"
    field :user, non_null(:user) do
      #      resolve &Resolvers.Users.get_user/3
      resolve fn _, _, _ ->
        {
          :ok,
          %User{
            email: "some updated email",
            name: "some updated name",
            picture: "some updated picture",
            uid: "some updated uid"
          }
        }
      end
    end
  end
end
