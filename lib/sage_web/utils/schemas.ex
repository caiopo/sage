defmodule SageWeb.Utils.Schemas do
  use Absinthe.Schema.Notation

  defmacro field!(identifier, type) do
    quote do
      field(unquote(identifier), non_null(unquote(type)))
    end
  end

  defmacro field!(identifier, type, body) do
    quote do
      field(unquote(identifier), non_null(unquote(type)), unquote(body))
    end
  end

  defmacro arg!(identifier, type) do
    quote do
      arg(unquote(identifier), non_null(unquote(type)))
    end
  end

  defmacro list_of!(type) do
    quote do
      list_of(non_null(unquote(type)))
    end
  end

  defmacro public!() do
    quote do
      middleware SageWeb.Middlewares.PublicResolver
    end
  end
end
