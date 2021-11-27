alias Sage.Repo
alias Sage.Surveys.{Survey, Question}
alias Sage.Surveys

{:ok, survey} =
  Surveys.create_survey(%{
    uuid: "8ff197ba-ea8a-4061-bfc1-534db532a774",
    title: "Test Survey"
  })

questions = [
  %{
    uuid: Ecto.UUID.generate(),
    title: "What's your favorite color?",
    type: :single,
    data: %{"options" => ["Red", "Green", "Blue"]}
  },
  %{
    uuid: Ecto.UUID.generate(),
    title: "Which fruits do you like?",
    type: :multi,
    data: %{"options" => ["Apple", "Banana", "Pear"]}
  }
]

Surveys.upsert_questions(survey, questions)

# for q <- questions do
#   Repo.insert!(q)
# end
