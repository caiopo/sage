defmodule Sage.Struct do
  defmacro __using__(_) do
    quote do
      use TypedStruct
      use Domo

      @derive Jason.Encoder

      alias Uniq.UUID

      alias Sage.Validators
    end
  end
end
