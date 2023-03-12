defmodule Sage.EventStore do
  use EventStore, otp_app: :sage, schema: "eventstore"
end
