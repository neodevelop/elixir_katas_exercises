defmodule AdventOfCode.Year2018.Day1 do
  def sum_numbers(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
    |> Enum.sum()
  end

  def find_frequency_twice(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
    |> find_frequency()
  end

  defp find_frequency(l) do
    find_and_cycle(l, l, [0])
  end

  defp find_and_cycle([], original_list, freqs) do
    find_and_cycle(original_list, original_list, freqs)
  end

  defp find_and_cycle([h | t], original_list, freqs) do
    last =
      List.last(freqs)
      |> Kernel.+(h)

    freqs
    |> Enum.any?(fn e -> e == last end)
    |> case do
      true ->
        last

      false ->
        find_and_cycle(t, original_list, freqs ++ [last])
    end
  end
end
