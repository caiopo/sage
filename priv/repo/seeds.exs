alias Ash.Changeset

alias Sage.{Accounts, Surveys}
alias Sage.Accounts.User
alias Sage.Surveys.{Survey, Question}

user =
  User
  |> Changeset.for_create(:register_with_password,
    name: "Lorem ipsum",
    email: "lorem@ipsum.com",
    password: "hello123",
    password_confirmation: "hello123"
  )
  |> Accounts.create!()

survey =
  Survey
  |> Changeset.for_create(
    :create,
    %{
      title: "Hello survey",
      questions: [
        %{
          title: "Favorite color?",
          description: "Description hello world",
          type: :single,
          attributes: %{
            options: [
              "Red",
              "Green",
              "Blue"
            ]
          }
        }
      ]
    },
    actor: user
  )
  |> Surveys.create!()
