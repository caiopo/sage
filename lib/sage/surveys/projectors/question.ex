defmodule Sage.Surveys.Projectors.Question do
  use Commanded.Projections.Ecto,
    application: Sage.Commanded,
    name: "Surveys.Projectors.Question",
    consistency: :strong

  alias Sage.Surveys.Events.{
    QuestionCreated,
    QuestionsSorted
  }

  alias Sage.Surveys.Projections.Question

  project(%QuestionCreated{} = created, fn multi ->
    Ecto.Multi.insert(multi, :question_created, %Question{
      id: created.survey_id,
      survey_id: created.survey_id,
      title: created.title,
      description: created.description,
      attributes: created.attributes
    })
  end)

  project(%QuestionsSorted{survey_id: survey_id, question_ids: question_ids}, fn multi ->
    IO.inspect(["Sorted -> ", survey_id, question_ids])
  end)
end
