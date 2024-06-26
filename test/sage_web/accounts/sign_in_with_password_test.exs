defmodule SageWeb.Accounts.SignInWithPasswordTest do
  use SageWeb.ConnCase

  import Matcher

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
      |> send_query(
        """
          mutation($email: String!, $password: String!) {
            signInWithPassword(email: $email, password: $password) {
              #{document_for(:user_with_token)}
            }
          }
        """,
        %{
          email: email,
          password: password
        }
      )

    assert matches?(
             %{
               data: %{
                 sign_in_with_password: %{
                   id: predicate(fn t -> byte_size(t) > 0 end),
                   token: predicate(fn t -> byte_size(t) > 0 end),
                   name: "Lorem Ipsum",
                   email: email
                 }
               }
             },
             response
           )
  end
end
