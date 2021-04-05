defmodule AdventOfCode.Year2020.Day3 do

  def multiple_walk(path, slopes) do
    for {horizontal, vertical} <- slopes,
      do: walk(path, horizontal, vertical)
  end

  def walk(path, slope \\ 3, vertical_slope \\ 1) do
    path
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.duplicate(&1, 100))
    |> List.pop_at(0)
    |> elem(1)
    |> find_trees([], 1, slope, vertical_slope)
    |> count_trees()
  end

  defp find_trees([], walked, _, _, _), do: walked
  defp find_trees(forest, walked, positions, slope, vertical_slope) do
    [path | rest] = forest |> walk_vertical_slope(vertical_slope - 1)
    new_path = path |> String.split("")

    new_path = case new_path |> Enum.fetch!(positions + slope) do
      "." -> new_path |> List.replace_at(positions + slope, "O")
      "#" -> new_path |> List.replace_at(positions + slope, "X")
    end

    find_trees(rest, walked ++ [new_path], positions + slope, slope, vertical_slope)
  end

  defp count_trees(path) do
    path
    |> Enum.map(fn l -> Enum.filter(l, fn e -> e == "X" end) end)
    |> Enum.flat_map(fn e -> e end)
    |> Enum.count()
  end

  defp walk_vertical_slope(forest, 0), do: forest
  defp walk_vertical_slope([_path | rest], vertical_slope) do
    walk_vertical_slope(rest, vertical_slope - 1)
  end

end
