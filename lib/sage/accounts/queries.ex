defmodule Sage.Accounts.Queries do
  import Ecto.Query

  alias Sage.Accounts.Projections.User

  def by_id(user_id) do
    from u in User,
      where: u.id == ^user_id
  end
end
