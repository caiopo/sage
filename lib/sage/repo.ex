defmodule Sage.Repo do
  use AshPostgres.Repo, otp_app: :sage

  def installed_extensions do
    [
      "ash-functions",
      "citext"
    ]
  end
end
