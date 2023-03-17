defmodule SageWeb.Integration.CreateUserTest do
  use SageWeb.ConnCase

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

  test "mutation: createUser", %{conn: conn, user: user} do
    conn
    |> send_query(@viewer_query)
    |> assert_response(%{
      "viewer" => %{"email" => user.email, "name" => user.name, "id" => user.id}
    })
  end
end
