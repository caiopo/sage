defmodule Sage.Validators.Password do
  def valid?(password) do
    cond do
      byte_size(password) < 12 -> false
      not Regex.match?(~r/[a-z]/, password) -> false
      not Regex.match?(~r/[A-Z]/, password) -> false
      not Regex.match?(~r/[!?@#$%^&*_0-9]/, password) -> false
      true -> true
    end
  end
end
