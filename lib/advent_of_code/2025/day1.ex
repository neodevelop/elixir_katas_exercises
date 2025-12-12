defmodule AdventOfCode.Year2025.Day1 do
  def password(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn
      <<?R::utf8, n::binary>> -> {:right, String.to_integer(n)}
      <<?L::utf8, n::binary>> -> {:left, String.to_integer(n)}
    end)
    |> Enum.map_reduce(50, &rotate(&1, &2))
    |> elem(0)
    |> Enum.count(fn {_, _, dial} -> dial == 0 end)
  end

  defp rotate({:right, n}, dial) do
    new_dial = increment(n, dial)
    {{:right, n, new_dial}, new_dial}
  end

  defp rotate({:left, n}, dial) do
    new_dial = decrement(n, dial)
    {{:left, n, new_dial}, new_dial}
  end

  defp increment(0, dial), do: dial
  defp increment(n, 99), do: increment(n - 1, 0)
  defp increment(n, dial), do: increment(n - 1, dial + 1)

  defp decrement(0, dial), do: dial
  defp decrement(n, 0), do: decrement(n - 1, 99)
  defp decrement(n, dial), do: decrement(n - 1, dial - 1)
end
