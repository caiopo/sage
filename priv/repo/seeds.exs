# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Sage.Repo.insert!(%Sage.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Sage.Repo
alias Sage.Surveys.{Survey, Question}

survey =
  Repo.insert!(%Survey{
    uuid: "8ff197ba-ea8a-4061-bfc1-534db532a774",
    title: "Test Survey"
  })

questions = [
  %Question{
    survey: survey,
    uuid: Ecto.UUID.generate(),
    title: "What's your favorite color?",
    type: :single,
    data: %{"options" => ["Red", "Green", "Blue"]}
  },
  %Question{
    survey: survey,
    uuid: Ecto.UUID.generate(),
    title: "Which fruits do you like?",
    type: :multi,
    data: %{"options" => ["Apple", "Banana", "Pear"]}
  }
]

for q <- questions do
  Repo.insert!(q)
end
