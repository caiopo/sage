defmodule SageWeb.Accounts.RegisterWithPasswordTest do
  use SageWeb.ConnCase

  test "registerWithPassword", %{conn: conn} do
    email = "lorem@ipsum.com"

    response =
      conn
      |> send_query("""
        mutation {
          registerWithPassword(
            input: {
              email: "#{email}"
              name: "Lorem Ipsum"
              password: "12341234"
              passwordConfirmation: "12341234"
            }
          ) {
            errors {
              code
              fields
              message
              shortMessage
              vars
            }
            metadata {
              token
            }
            result {
              email
              id
              name
            }
          }
        }
      """)

    assert not is_map_key(response, "errors")

    register = response["data"]["registerWithPassword"]

    assert Enum.empty?(register["errors"])
    assert byte_size(register["metadata"]["token"]) > 0

    user = register["result"]

    assert byte_size(user["id"]) > 0

    assert user["name"] == "Lorem Ipsum"
    assert user["email"] == email
  end
end
