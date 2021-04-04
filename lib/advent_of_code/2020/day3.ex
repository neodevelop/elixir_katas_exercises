defmodule AdventOfCode.Year2020.Day3 do

  def walk(path, slope \\ 3) do
    path
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.duplicate(&1, 100))
    |> List.pop_at(0)
    |> elem(1)
    |> find_trees([], 1, slope)
    |> count_trees()
  end

  defp find_trees([], walked, _, _), do: walked
  defp find_trees([path | rest], walked, positions, slope) do
    new_path = path |> String.split("")

    new_path = case new_path |> Enum.fetch!(positions + slope) do
      "." -> new_path |> List.replace_at(positions + slope, "O")
      "#" -> new_path |> List.replace_at(positions + slope, "X")
    end

    find_trees(rest, walked ++ [new_path], positions + slope, slope)
  end

  defp count_trees(path) do
    path
    |> Enum.map(fn l -> Enum.filter(l, fn e -> e == "X" end) end)
    |> Enum.flat_map(fn e -> e end)
    |> Enum.count()
  end

end
