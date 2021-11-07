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

survey = %Survey{
  uuid: "8ff197ba-ea8a-4061-bfc1-534db532a774",
  title: "Lorem ipsum"
}

Repo.insert!(survey)

question = %Question{
  title: "Dolor sit amet",
  type: :single,
  data: %{"a" => "b", "hello" => 2},
  survey: survey
}

Repo.insert!(question)
