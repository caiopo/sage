defmodule SageWeb.Resolvers.AccountsResolver do
  alias Sage.Accounts

  def viewer(_parent, _context) do
    {:ok, %{id: "123", email: "hello@world.com"}}
  end

  def user(_parent, args, _context) do
    {:ok, %{id: args.id, email: "hello@world.com"}}
  end

  def create_user(_parent, %{input: input}, _context) do
    err =
      with {:ok, user} <- Accounts.register_user(input),
           token <- Accounts.generate_user_session_token(user) do
        {:ok, %{token: Base.url_encode64(token), user: user}}
      end

    IO.inspect(err)

    err
  end

  def login(_parent, %{input: input}, _context) do
    user = Accounts.get_user_by_email_and_password(input.email, input.password)

    case user do
      nil ->
        {:error, "Invalid credentials"}

      _ ->
        token = Accounts.generate_user_session_token(user)
        {:ok, %{token: Base.url_encode64(token), user: user}}
    end
  end
end
