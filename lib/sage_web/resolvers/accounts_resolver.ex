defmodule SageWeb.Resolvers.AccountsResolver do
  alias Sage.Accounts

  def viewer(_parent, %{context: %{current_user: user}}) do
    {:ok, user}
  end

  def create_user(_parent, %{input: input}, _context) do
    with {:ok, user} <- Accounts.register_user(input),
         token <- Accounts.generate_user_session_token(user) do
      {:ok, %{token: Base.url_encode64(token), user: user}}
    end
  end

  def login(_parent, %{input: input}, _context) do
    Accounts.get_user_by_email_and_password(input.email, input.password)
    |> case do
      nil ->
        {:error, "Invalid credentials"}

      user ->
        token = Accounts.generate_user_session_token(user)
        {:ok, %{token: Base.url_encode64(token), user: user}}
    end
  end
end
