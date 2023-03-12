defmodule Sage.Surveys.Queries do
  import Ecto.Query

  alias Sage.Surveys.Projections.Survey

  def by_id(survey_id) do
    from(
      s in Survey,
      where: s.id == ^survey_id
    )
  end

  def for_user(user_id, exclude_archived: exclude?) do
    from(
      s in Survey,
      where: s.user_id == ^user_id
    )
    |> exclude_archived(exclude?)
  end

  defp exclude_archived(query, exclude?) do
    if exclude? do
      from(
        s in query,
        where: is_nil(s.archived_at)
      )
    else
      query
    end
  end
end
