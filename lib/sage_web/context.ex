defmodule SageWeb.Context do
  @behaviour Plug

  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _) do
    context = build_context(conn)
    Absinthe.Plug.put_options(conn, context: context)
  end

  @doc """
  Return the current user context based on the authorization header
  """
  def build_context(conn) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, current_user} <- authorize(token) do
      %{current_user: current_user}
    else
      _ -> %{}
    end
  end

  defp authorize(token) do
    case ExFirebaseAuth.Token.verify_token(token) do
      {:ok, uid, jwt} ->
        {:ok, Sage.Accounts.get_or_create_user(%{
          uid: uid,
          name: jwt.fields["name"],
          email: jwt.fields["email"],
          picture: jwt.fields["picture"]
        })}
      _ ->
        {:err, "Invalid token"}
    end
  end
end
