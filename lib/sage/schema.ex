defmodule Sage.Schema do
  use Absinthe.Schema

  @apis [Sage.Accounts, Sage.Surveys]

  use AshGraphql, apis: @apis

  query do
  end

  mutation do
  end
end
