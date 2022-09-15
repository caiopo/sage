defmodule SageWeb.Context do
  @behaviour Plug

  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _) do
    case build_context(conn) do
      {:ok, context} ->
        put_private(conn, :absinthe, %{context: context})

      a ->
        IO.inspect(a)
        conn
    end
  end

  defp build_context(conn) do
    IO.inspect(get_req_header(conn, "authorization"))

    with ["Bearer " <> encoded_token] <- get_req_header(conn, "authorization"),
         {:ok, token} <- Base.url_decode64(encoded_token),
         %Sage.Accounts.User{} = user <- Sage.Accounts.get_user_by_session_token(token) do
      {:ok, %{current_user: user}}
    end
  end
end
