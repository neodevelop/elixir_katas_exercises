defmodule AdventOfCode.Year2024.Day1 do
  def total_distance(side_by_side) do
    side_by_side
    |> String.split("\n")
    |> Enum.map(&String.split(&1, "   "))
    |> create_single_list()
    |> string_to_integer()
    |> set_order()
    |> compute_distance()
    |> elem(2)
    |> Enum.sum()
  end

  def similarity_score(side_by_side) do
    side_by_side
    |> String.split("\n")
    |> Enum.map(&String.split(&1, "   "))
    |> create_single_list()
    |> string_to_integer()
    |> compute_similarity()
    |> Enum.sum()
  end

  defp create_single_list(list) do
    list
    |> Enum.filter(&(Enum.count(&1) == 2))
    |> Enum.reduce({[], []}, fn
      [a, b], {l1, l2} -> {l1 ++ [a], l2 ++ [b]}
    end)
  end

  defp string_to_integer({l1, l2}) do
    {
      l1 |> Enum.map(&String.to_integer/1),
      l2 |> Enum.map(&String.to_integer/1)
    }
  end

  defp set_order({l1, l2}) do
    {
      l1 |> Enum.sort(),
      l2 |> Enum.sort()
    }
  end

  defp compute_distance({l1, l2}) do
    {l1, l2, compute_distance(l1, l2, [])}
  end

  defp compute_distance([], [], r), do: r

  defp compute_distance([h1 | t1], [h2 | t2], r) do
    compute_distance(t1, t2, r ++ [(h1 - h2) |> abs()])
  end

  defp compute_similarity({l1, l2}) do
    l1
    |> Enum.map(&Enum.count(l2, fn e -> e == &1 end))
    |> Enum.zip_with(l1, fn l, r -> l * r end)
  end
end
