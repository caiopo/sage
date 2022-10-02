defmodule SageWeb.Adapters.Questions do
  def to_wire(question) do
    Map.merge(
      %{
        id: question.id,
        title: question.title
      },
      question.attributes
    )
  end
end
