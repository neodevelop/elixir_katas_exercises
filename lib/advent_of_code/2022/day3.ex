defmodule AdventOfCode.Year2022.Day3 do
  def prioritize(rucksacks) do
    rucksacks
    |> String.split("\n", trim: true)
    |> Enum.map(&split_half/1)
    |> Enum.map(&match_item/1)
    |> match_priorities()
  end

  def prioritize_groups(rucksacks) do
    rucksacks
    |> String.split("\n", trim: true)
    |> group_every_3()
    |> Enum.map(&match_groups/1)
    |> match_group_priorites()
  end

  defp split_half(s) do
    [
      String.slice(s, 0..(ceil(String.length(s) / 2) - 1))
      |> String.split("", trim: true),
      String.slice(s, ceil(String.length(s) / 2), String.length(s))
      |> String.split("", trim: true)
    ]
  end

  defp match_item([l1, l2]) do
    for i1 <- l1, i2 <- l2, match = i1 == i2, uniq: true, do: {match, i1, i2}
  end

  defp match_priorities(items) do
    all_priorities = low_priorities() ++ high_priorities()
    for [{_, e, _}] <- items, {^e, n} <- all_priorities, do: n
  end

  defp group_every_3(list) do
    group_every_3(list, [])
  end

  defp group_every_3([], groups), do: groups

  defp group_every_3([h1 | [h2 | [h3 | rest]]], groups) do
    group = [h1, h2, h3] |> Enum.map(&String.split(&1, "", trim: true))
    group_every_3(rest, groups ++ [group])
  end

  defp match_groups([g1, g2, g3]) do
    for e <- g1, ^e <- g2, ^e <- g3, uniq: true, do: e
  end

  defp match_group_priorites(groups_matches) do
    all_priorities = low_priorities() ++ high_priorities()
    for [e] <- groups_matches, {^e, n} <- all_priorities, do: n
  end

  defp high_priorities() do
    lower_letters =
      Enum.to_list(?a..?z)
      |> List.to_string()
      |> String.split("", trim: true)

    for number <- 1..26, do: {Enum.at(lower_letters, number - 1), number}
  end

  defp low_priorities() do
    upcase_letters =
      Enum.to_list(?A..?Z)
      |> List.to_string()
      |> String.split("", trim: true)

    for number <- 27..52, do: {Enum.at(upcase_letters, number - 27), number}
  end
end
