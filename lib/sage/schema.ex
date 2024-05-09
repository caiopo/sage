defmodule Sage.Schema do
  use Absinthe.Schema

  @domains [Sage.Accounts, Sage.Surveys]

  use AshGraphql, domains: @domains

  query do
  end

  mutation do
  end
end
