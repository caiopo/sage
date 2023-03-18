defmodule Sage.Surveys.Supervisor do
  use Supervisor

  alias Sage.Surveys

  def start_link(arg) do
    Supervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  def init(_arg) do
    Supervisor.init(
      [
        Surveys.Projectors.Survey,
        Surveys.Projectors.Question
      ],
      strategy: :one_for_one
    )
  end
end
