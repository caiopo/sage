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

# user_ids =
#   1..100
#   |> Task.async_stream(fn i ->
#     {:ok, %{id: user_id}} =
#       Accounts.register_user(
#         email: Faker.Internet.email(),
#         password: "Loremipsum123"
#       )

#     user_id
#   end)
#   |> Stream.map(fn {:ok, id} -> id end)
#   |> Enum.to_list()

# 1..500
# |> Task.async_stream(fn i ->
#   {:ok, %{id: survey_id}} =
#     Surveys.create_survey(%{
#       user_id: Enum.random(user_ids),
#       title: Faker.Lorem.sentence()
#     })

#   if rem(i, 25) == 0 do
#     Surveys.update_survey_title(%{
#       survey_id: survey_id,
#       title: Faker.Lorem.sentence()
#     })
#   end

#   if rem(i, 100) == 0 do
#     Surveys.archive_survey(%{survey_id: survey_id})
#   end
# end)
# |> Enum.to_list()

{:ok, %{id: user_id}} =
  Accounts.register_user(
    email: Faker.Internet.email(),
    password: "Loremipsum123"
  )

{:ok, %{id: survey_id}} =
  Surveys.create_survey(%{
    user_id: user_id,
    title: Faker.Lorem.sentence()
  })

{:ok, _} = Surveys.create_question(%{
  survey_id: survey_id,
  title: Faker.Lorem.sentence(),
  description: Faker.Lorem.sentence(),
  attributes:
    Surveys.QuestionTypes.from_map!(%{
      type: :single,
      options: ["Banana", "Morango", "Goiaba"]
    })
})
