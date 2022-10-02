defmodule SageWeb.Integration.AccountsTest do
  use SageWeb.ConnCase

  setup :register_and_log_in_user

  test "query: viewer", %{conn: conn, user: user} do
    conn
    |> send_query("""
    {
      viewer {
        #{document_for(:user)}
      }
    }
    """)
    |> assert_response(%{
      "viewer" => %{
        "email" => user.email,
        "name" => user.name,
        "id" => user.id,
        "__typename" => "User"
      }
    })
  end
end
