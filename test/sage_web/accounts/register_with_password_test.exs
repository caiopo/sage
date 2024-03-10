defmodule SageWeb.Accounts.RegisterWithPasswordTest do
  use SageWeb.ConnCase

  import Matcher

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

    assert matches?(
             %{
               data: %{
                 errors: [],
                 register_with_password: %{
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
