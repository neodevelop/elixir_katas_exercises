defmodule AdventOfCode.Year2023.Day1 do
  # @numbers ~s/one two three four five six seven eight nine/

  def calibrate(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&found_calibration/1)
    |> Enum.sum()
  end

  defp found_calibration(value) do
    ~r/\d/
    |> Regex.scan(value)
    |> Enum.map(fn [e] -> e end)
    |> join_first_and_last()
  end

  defp join_first_and_last(matches) do
    [List.first(matches), List.last(matches)]
    |> Enum.join()
    |> String.to_integer()
  end
end
