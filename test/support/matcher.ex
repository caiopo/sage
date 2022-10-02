defmodule Sage.Matcher do
  defmacro assert_matches?(expected, actual) do
    quote do
      assert Sage.Matcher.stringify_keys(unquote(expected)) == unquote(actual)
    end
  end

  @doc """
  Convert map atom keys to strings
  """
  def stringify_keys(nil), do: nil

  def stringify_keys(map = %{}) do
    map
    |> Enum.map(fn {k, v} -> {stringify(k), stringify_keys(v)} end)
    |> Enum.into(%{})
  end

  # Walk the list and stringify the keys of
  # of any map members
  def stringify_keys([head | rest]) do
    [stringify_keys(head) | stringify_keys(rest)]
  end

  def stringify_keys(not_a_map) do
    not_a_map
  end

  defp stringify(val) when is_atom(val), do: Atom.to_string(val)
  defp stringify(val), do: val
end
