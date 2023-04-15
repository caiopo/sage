defmodule Sage.UUID do
  def generate() do
    Uniq.UUID.uuid7()
  end
end
