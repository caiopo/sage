defmodule Sage.Validators.Email do
  def valid?(email) do
    Regex.match?(~r/^[A-Za-z0-9._+\-\']+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}$/i, email)
  end
end
