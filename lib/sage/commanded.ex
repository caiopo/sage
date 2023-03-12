defmodule Sage.Commanded do
  use Commanded.Application, otp_app: :sage

  router(Sage.Router)
end
