defmodule SageWeb.Accounts.SignInWithPasswordTest do
  use SageWeb.ConnCase

  test "signInWithPassword", %{conn: conn} do
    email = "lorem@ipsum.com"
    password = "hello123"

    User
    |> Ash.Changeset.for_create(:register_with_password,
      name: "Lorem Ipsum",
      email: email,
      password: password,
      password_confirmation: password
    )
    |> Accounts.create!()

    response =
      conn
      |> send_query("""
        mutation {
          signInWithPassword(email: "#{email}", password: "#{password}") {
            email
            id
            name
            token
          }
        }
      """)

    assert not is_map_key(response, "errors")

    user = response["data"]["signInWithPassword"]

    assert byte_size(user["token"]) > 0
    assert byte_size(user["id"]) > 0
    assert user["name"] == "Lorem Ipsum"
    assert user["email"] == email
  end
end
