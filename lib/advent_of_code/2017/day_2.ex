defmodule AdventOfCode.Year2017.Day2 do
  def checksum(grid) do
    grid
    |> String.split("\n")
    |> Enum.map(fn line ->
      line
      |> String.split(~r/\s+/)
      |> Enum.map(&String.to_integer/1)
    end)
    |> Enum.map(fn line ->
      Enum.max(line) - Enum.min(line)
    end)
    |> Enum.sum()
  end

  def checksum_evenly_divisible(grid) do
    grid
    |> String.split("\n")
    |> Enum.map(fn line ->
      line
      |> String.split(~r/\s+/)
      |> Enum.map(&String.to_integer/1)
    end)
    |> Enum.map(fn line ->
      [h | _] = for x <- line, y <- line, x != y, rem(x, y) == 0, do: floor(x / y)
      h
    end)
    |> Enum.sum()
  end
end
