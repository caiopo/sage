defmodule Sage.Repo do
  use Ecto.Repo,
    otp_app: :sage,
    adapter: Ecto.Adapters.Postgres
end
