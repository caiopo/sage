defmodule Sage.Commanded do
  use Commanded.Application, otp_app: :sage

  router(Sage.Router)

  def maybe_dispatch({:ok, command}) do
    dispatch(
      command,
      consistency: :strong,
      returning: :aggregate_state
    )
  end

  def maybe_dispatch(other) do
    other
  end
end
