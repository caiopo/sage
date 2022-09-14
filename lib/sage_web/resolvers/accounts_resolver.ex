defmodule SageWeb.Resolvers.AccountsResolver do
  alias Sage.Accounts

  def get_viewer(_parent, _context) do
    {:ok, %{id: "123", email: "hello@world.com"}}
  end

  def get_user(_parent, args, _context) do
    {:ok, %{id: args.id, email: "hello@world.com"}}
  end

  def create_user(_parent, args, _context) do
    Accounts.register_user(args)
  end

  def login(_parent, args, _context) do
    user = Accounts.get_user_by_email_and_password(args.email, args.password)
    {:ok, []}
  end
end
