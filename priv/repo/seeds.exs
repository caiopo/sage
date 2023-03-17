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

Faker.start()

alias Sage.Gen
alias Sage.Accounts
alias Sage.Surveys

user_ids =
  for i <- 1..100 do
    {:ok, %{id: user_id}} =
      Accounts.register_user(
        email: Faker.Internet.email(),
        password: "Loremipsum123"
      )

    user_id
  end

for i <- 1..500 do
  {:ok, %{id: survey_id}} =
    Surveys.create_survey(%{
      user_id: Enum.random(user_ids),
      title: Faker.Lorem.sentence()
    })

  if rem(i, 25) == 0 do
    Surveys.update_survey_title(%{
      survey_id: survey_id,
      title: Faker.Lorem.sentence()
    })
  end

  if rem(i, 100) == 0 do
    Surveys.archive_survey(%{survey_id: survey_id})
  end
end
