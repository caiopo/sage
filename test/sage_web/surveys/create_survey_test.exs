defmodule SageWeb.Surveys.CreateSurveyTest do
  use SageWeb.ConnCase

  setup :login

  test "createSurvey", %{conn: conn} do
    survey = %{
      title: "My survey",
      questions: [
        %{
          title: "What is your name?",
          type: "TEXT"
        },
        %{
          title: "What is your age?",
          type: "NUMBER"
        }
      ]
    }

    response =
      conn
      |> send_query(
        """
        mutation($input: CreateSurveyInput!) {
          createSurvey(input: $input) {
            #{document_for(:create_survey_result)}
          }
        }
        """,
        %{input: survey}
      )

    IO.inspect(response)

    assert matches?(
             %{
               data: %{
                 create_survey: %{
                   errors: [],
                   result: %{}
                 }
               }
             },
             response
           )
  end
end
