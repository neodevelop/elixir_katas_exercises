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
    |> Enum.map_reduce(50, &rotate_to_once(&1, &2))
    |> elem(0)
    |> Enum.map(fn {_, _, {counter, _}} -> counter end)
    |> Enum.count(&(&1 > 0))
    |> dbg()
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

  defp rotate_to_once({:right, n}, dial) do
    {counter, new_dial} = increment_to_once(n, 0, dial)
    {{:right, n, {counter, new_dial}}, new_dial}
  end

  defp rotate_to_once({:left, n}, dial) do
    {counter, new_dial} = decrement_to_once(n, 0, dial)
    {{:left, n, {counter, new_dial}}, new_dial}
  end

  defp increment_to_once(0, counter, dial), do: {counter, dial}
  defp increment_to_once(n, counter, 99), do: increment_to_once(n - 1, counter + 1, 0)
  defp increment_to_once(n, counter, dial), do: increment_to_once(n - 1, counter, dial + 1)

  defp decrement_to_once(0, counter, dial), do: {counter, dial}
  defp decrement_to_once(n, counter, 0), do: decrement_to_once(n - 1, counter + 1, 99)
  defp decrement_to_once(n, counter, dial), do: decrement_to_once(n - 1, counter, dial - 1)
end
