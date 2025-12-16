defmodule AdventOfCode.Year2025.Day3 do
  def maximum_joltage(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, "", trim: true))
  end
end
