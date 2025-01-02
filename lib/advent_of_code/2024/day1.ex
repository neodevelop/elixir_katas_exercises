defmodule AdventOfCode.Year2024.Day1 do
  def total_distance(side_by_side) do
    side_by_side
    |> parse_input()
    |> transform_to_integers()
    |> sort_lists()
    |> compute_distance()
    |> elem(2)
    |> Enum.sum()
  end

  def similarity_score(side_by_side) do
    side_by_side
    |> parse_input()
    |> transform_to_integers()
    |> compute_similarity()
    |> Enum.sum()
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, "   ", trim: true))
    |> Enum.filter(&(length(&1) == 2))
    |> Enum.reduce({[], []}, fn [a, b], {l1, l2} ->
      {l1 ++ [a], l2 ++ [b]}
    end)
  end

  defp transform_to_integers({l1, l2}) do
    {
      Enum.map(l1, &String.to_integer/1),
      Enum.map(l2, &String.to_integer/1)
    }
  end

  defp sort_lists({l1, l2}) do
    {Enum.sort(l1), Enum.sort(l2)}
  end

  defp compute_distance({l1, l2}) do
    {l1, l2, compute_distance_recursively(l1, l2, [])}
  end

  defp compute_distance_recursively([], [], acc), do: acc

  defp compute_distance_recursively([h1 | t1], [h2 | t2], acc) do
    compute_distance_recursively(t1, t2, [(h1 - h2) |> abs() | acc])
  end

  defp compute_similarity({l1, l2}) do
    counts = Enum.frequencies(l2)

    l1
    |> Enum.map(&(Map.get(counts, &1, 0) * &1))
  end
end
