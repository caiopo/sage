defmodule Sage.Repo do
  use AshPostgres.Repo, otp_app: :sage

  def installed_extensions do
    ["citext"]
  end
end
