defmodule Sage.Surveys.Aggregates.Question do
  use Sage.Struct

  typedstruct enforce: true do
    field :id, UUID.formatted(), enforce: false
    field :survey_id, UUID.formatted(), enforce: false
  end

  alias Sage.Surveys.Aggregates.Question

  alias Sage.Surveys.Commands.{
    CreateQuestion
  }

  alias Sage.Surveys.Events.{
    QuestionCreated
  }

  def execute(%Question{id: nil}, %CreateQuestion{} = command) do
    QuestionCreated.new(Map.from_struct(command))
  end

  def apply(%Question{} = question, %QuestionCreated{} = created) do
    %{
      question
      | id: created.question_id,
        survey_id: created.survey_id
    }
  end
end
