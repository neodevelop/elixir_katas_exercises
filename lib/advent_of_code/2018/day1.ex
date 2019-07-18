defmodule AdventOfCode.Year2018.Day1 do

  def sum_numbers([], accum, _sums) do
    accum
  end

  def sum_numbers([h|t], accum, sums) do

    new_frequency = accum + h
    counter = case Map.get(sums, new_frequency) do
      nil -> 0
      x -> x + 1
    end

    new_sums = sums |> Map.put(new_frequency, counter)

    # IO.puts """
    #   New frequency: #{new_frequency}
    #   Current sum: #{accum}
    #   Sums: #{inspect sums}
    # """

    case Enum.find(sums, fn {_, n} -> n > 0 end) do
      {x, _} -> IO.puts "Twice #{x}"
      nil -> :noop
    end

    sum_numbers(t, new_frequency, new_sums)
  end

end

