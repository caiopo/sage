defmodule Sage.Gen do
  def uuid() do
    Uniq.UUID.uuid7()
  end
end
