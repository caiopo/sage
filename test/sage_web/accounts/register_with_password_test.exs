defmodule SageWeb.Accounts.RegisterWithPasswordTest do
  use SageWeb.ConnCase

  import Matcher

  test "registerWithPassword", %{conn: conn} do
    email = "lorem@ipsum.com"

    response =
      conn
      |> send_query(
        """
        mutation($input: RegisterWithPasswordInput!) {
          registerWithPassword(input: $input) {
            #{document_for(:register_with_password_result)}
          }
        }
        """,
        %{
          input: %{
            name: "Lorem Ipsum",
            email: email,
            password: "password",
            passwordConfirmation: "password"
          }
        }
      )

    assert matches?(
             %{
               data: %{
                 register_with_password: %{
                   errors: [],
                   metadata: %{
                     token: predicate(fn t -> byte_size(t) > 0 end)
                   },
                   result: %{
                     id: predicate(fn t -> byte_size(t) > 0 end),
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
