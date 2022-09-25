defmodule SageWeb.Integration.AccountsTest do
  use SageWeb.ConnCase

  @viewer_query """
  {
    viewer {
      id
      name
      email
    }
  }
  """

  setup :register_and_log_in_user

  test "query: viewer", %{conn: conn, user: user} do
    conn
    |> send_query(@viewer_query)
    |> assert_response(%{
      "viewer" => %{"email" => user.email, "name" => user.name, "id" => user.id}
    })
  end
end
