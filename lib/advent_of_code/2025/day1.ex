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

  def password_method(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn
      <<?R::utf8, n::binary>> -> {:right, String.to_integer(n)}
      <<?L::utf8, n::binary>> -> {:left, String.to_integer(n)}
    end)
    |> Enum.reduce({50, 0}, fn move, {dial, acc} ->
      {zeros, new_dial} = rotate_count(move, dial)
      {new_dial, acc + zeros}
    end)
    |> elem(1)
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

  defp rotate_count({:right, n}, s) do
    zeros = count_hits_right(s, n)
    new_dial = rem(s + n, 100)
    {zeros, new_dial}
  end

  defp rotate_count({:left, n}, s) do
    zeros = count_hits_left(s, n)
    new_dial = rem(s - n, 100)
    new_dial = if new_dial < 0, do: new_dial + 100, else: new_dial
    {zeros, new_dial}
  end

  defp count_hits_right(0, n), do: div(n, 100)

  defp count_hits_right(s, n) do
    first = 100 - s
    if n < first, do: 0, else: 1 + div(n - first, 100)
  end

  defp count_hits_left(0, n), do: div(n, 100)

  defp count_hits_left(s, n) do
    first = s
    if n < first, do: 0, else: 1 + div(n - first, 100)
  end
end
