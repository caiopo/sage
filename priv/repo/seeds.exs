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
import Sage.SurveysFixtures

{:ok, user} =
  Accounts.register_user(%{
    name: "Test Testing",
    email: "example@example.com",
    password: "abc1234567890"
  })

{:ok, survey} =
  Surveys.create_new_survey(%{
    title: "My Testing Survey"
  })

Surveys.grant_survey_user_role(survey, user, :admin)

for i <- 1..50 do
  question_fixture(Enum.random([:single, :multi, :text, :number]), survey: survey)
end

# {:ok, _} =
#   Surveys.create_question(%{
#     survey: survey,
#     title: "What's your favorite color?",
#     order: 1,
#     attributes: %{
#       type: :single,
#       options: ~w(Red Blue Green)
#     }
#   })

# {:ok, _} =
#   Surveys.create_question(%{
#     survey: survey,
#     title: "Which fruit do you like?",
#     order: 2,
#     attributes: %{
#       type: :multi,
#       options: ~w(Apple Banana Guava)
#     }
#   })

# {:ok, _} =
#   Surveys.create_question(%{
#     survey: survey,
#     title: "What is your name?",
#     order: 3,
#     attributes: %{
#       type: :number,
#       min_length: 1
#     }
#   })

# {:ok, _} =
#   Surveys.create_question(%{
#     survey: survey,
#     title: "What is your age?",
#     order: 4,
#     attributes: %{
#       type: :number,
#       min_value: 0,
#       max_value: 120
#     }
#   })
