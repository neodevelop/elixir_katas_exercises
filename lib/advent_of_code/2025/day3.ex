defmodule AdventOfCode.Year2025.Day3 do
  def maximum_joltage(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, "", trim: true))
    |> Enum.map(&to_numbers/1)
    |> Enum.map(&find_batteries/1)
    |> Enum.sum()
  end

  defp to_numbers(list), do: Enum.map(list, &String.to_integer/1)

  defp find_batteries(list) do
    {battery_1, idx} =
      list
      |> Enum.drop(-1)
      |> find_max_battery(0, 0)

    to = length(list)
    from = length(list) - idx - 1

    {battery_2, _idx2} =
      list
      |> Enum.slice(from..to)
      |> find_max_battery(0, 0)

    "#{battery_1}#{battery_2}" |> String.to_integer()
  end

  defp find_max_battery([], battery, idx), do: {battery, idx}

  defp find_max_battery([h | t], battery, idx) do
    case h > battery do
      true -> find_max_battery(t, h, length(t))
      false -> find_max_battery(t, battery, idx)
    end
  end

  def ultra_maximum_joltage(input) do
    input
    |> parse_lines_digits()
    |> Enum.map(&max_number_from_digits(&1, 12))
    |> Enum.sum()
  end

  # ---------- helpers ----------

  defp parse_lines_digits(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.to_charlist()
      |> Enum.map(&(&1 - ?0))
    end)
  end

  defp max_number_from_digits(digits, k) do
    chosen =
      digits
      |> max_subsequence_k(digits |> length(), k)

    digits_to_integer(chosen)
  end

  # Greedy stack: elige subsecuencia de longitud k máxima (lexicográficamente)
  defp max_subsequence_k(digits, n, k) when k <= n do
    remove = n - k

    stack =
      Enum.reduce(digits, {[], remove}, fn d, {stk, rem_left} ->
        {stk2, rem2} = pop_while_smaller(stk, d, rem_left)
        {[d | stk2], rem2}
      end)
      |> elem(0)
      |> Enum.reverse()

    Enum.take(stack, k)
  end

  defp pop_while_smaller([top | rest], d, rem_left) when rem_left > 0 and top < d do
    pop_while_smaller(rest, d, rem_left - 1)
  end

  defp pop_while_smaller(stack, _d, rem_left), do: {stack, rem_left}

  defp digits_to_integer(digs) do
    Enum.reduce(digs, 0, fn d, acc -> acc * 10 + d end)
  end
end
