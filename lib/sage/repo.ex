defmodule Sage.Repo do
  use AshPostgres.Repo, otp_app: :sage

  def installed_extensions do
    ["uuid-ossp", "citext"]
  end
end
