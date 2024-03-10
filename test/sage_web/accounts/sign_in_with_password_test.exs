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

    assert matches?(
             %{
               data: %{
                 errors: [],
                 sign_in_with_password: %{
                   metadata: %{
                     token: predicate(fn t -> byte_size(t) > 0 end)
                   },
                   user: %{
                     name: "Lorem Ipsum",
                     email: email
                   }
                 }
               }
             },
             response
           )
  end
end
