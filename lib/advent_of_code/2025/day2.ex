defmodule AdventOfCode.Year2025.Day2 do
  def find_invalids(input) do
    input
    |> String.split(",", trim: true)
    |> Enum.map(&String.split(&1, "-", trim: true))
    |> Enum.map(fn [s, e] -> [String.trim(s), String.trim(e)] end)
    |> Enum.map(fn [s, e] -> String.to_integer(s)..String.to_integer(e) end)
    |> Enum.map(&Range.to_list/1)
    |> Enum.map(&find_invalid_ids/1)
    |> Enum.filter(&(!Enum.empty?(&1)))
    |> Enum.flat_map(fn e ->
      Enum.map(e, fn {i, _s, {_, _}} -> i end)
    end)
    |> Enum.sum()
    |> dbg()
  end

  defp find_invalid_ids(ids) do
    ids
    |> Enum.map(&{&1, Integer.to_string(&1)})
    |> Enum.map(fn {i, s} -> {i, s, String.split_at(s, div(String.length(s), 2))} end)
    |> Enum.filter(fn
      {_i, _s, {a, a}} -> true
      _ -> false
    end)
  end

  def find_invalids_twice(input) do
    input
    |> String.split(",", trim: true)
    |> Enum.map(&String.split(&1, "-", trim: true))
    |> Enum.map(fn [s, e] -> [String.trim(s), String.trim(e)] end)
    |> Enum.map(fn [s, e] -> String.to_integer(s)..String.to_integer(e) end)
    |> Enum.map(&Range.to_list/1)
    |> Enum.map(&find_invalid_twice_ids/1)
    |> Enum.filter(&(!Enum.empty?(&1)))
    |> Enum.flat_map(fn e ->
      Enum.map(e, fn {i, _s, {_, _}} -> i end)
    end)
    |> Enum.sum()
  end

  defp find_invalid_twice_ids(ids) do
    ids
    |> Enum.map(&{&1, Integer.to_string(&1)})
    |> Enum.map(fn {i, s} -> {i, s, String.split_at(s, div(String.length(s), 2))} end)
    |> Enum.filter(fn
      {_i, _s, {a, a}} -> true
      {_i, s, _} -> twice_id?(s)
      _ -> false
    end)
  end

  defp twice_id?(s) do
    chars = s |> String.split("", trim: true)
    chunk_limit = div(byte_size(s), 2)

    case chunk_limit do
      0 ->
        false

      _ ->
        for(i <- 1..chunk_limit, do: Enum.chunk_every(chars, i))
        |> Enum.map(fn e -> for i <- e, do: Enum.join(i, "") end)
        |> Enum.map(fn e -> Enum.all?(e, fn x -> x == hd(e) end) end)
        |> Enum.any?()
    end
  end
end
