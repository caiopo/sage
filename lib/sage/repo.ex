defmodule Sage.Repo do
  use Ecto.Repo,
    otp_app: :sage,
    adapter:
      if(Mix.env() in [:test],
        do: Ecto.Adapters.SQLite3,
        else: Ecto.Adapters.Postgres
      )
end
