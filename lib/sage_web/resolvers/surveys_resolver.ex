defmodule SageWeb.Resolvers.SurveysResolver do
  def list_surveys(_parent, _context) do
    {:ok, []}
  end

  def create_survey(_parent, _input, _context) do
    {:ok, nil}
  end

  def edit_survey(_parent, _input, _context) do
    {:ok, nil}
  end
end
