defmodule SageWeb.Resolvers.AccountsResolver do
  alias Sage.Accounts

  def get_viewer(_parent, _context) do
    IO.inspect(_parent)
    IO.inspect(_context)
    {:ok,
    %{id: "123", email: "hello@world.com"}}
  end

  def create_user(_parent, args, _context) do
    Accounts.register_user(args)
  end

  def login(_parent, args, _context) do
    {:ok, []}
  end
end
