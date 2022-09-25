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

alias Sage.Accounts
alias Sage.Surveys

{:ok, user} =
  Accounts.register_user(%{
    name: "Test Testing",
    email: "example@example.com",
    password: "abc1234567890"
  })

{:ok, survey} =
  Surveys.create_new_survey(%{
    title: "Minha Survey 123"
  })

Surveys.grant_survey_user_role(survey, user, :admin)
