defmodule AdventOfCode.Day10 do
  def look_and_say(word) do
    IO.puts("************")

    word
    |> make_list()
    |> process()
    |> Enum.reverse()
    |> count_uniques()
    |> Enum.join()
  end

  def make_list(s) do
    s |> String.split("") |> Enum.filter(&(&1 != ""))
  end

  def process(chars) do
    split_groups(chars, [])
  end

  def split_groups([], groups), do: groups

  def split_groups([h | t], groups) do
    group(t, h, groups)
  end

  def group([], nil, groups) do
    groups
  end

  def group([], c, groups) when not is_nil(c) do
    [[c] | groups]
  end

  def group(chars, c, groups) do
    {new_chars, group, new_char} = group_chars(c, chars, [])
    group(new_chars, new_char, [group | groups])
  end

  defp group_chars(c, [], group) do
    {[], [c | group], c}
  end

  defp group_chars(c, [h | t] = _chars, group) do
    new_group =
      case String.equivalent?(c, h) do
        true ->
          [c | group]

        false ->
          group
      end

    case t do
      [] ->
        {[], new_group, h}

      _ ->
        group_chars(h, t, new_group)
    end
  end

  defp count_uniques(groups) do
    for u <- groups, [s | _] = u, c = Enum.count(u) |> Integer.to_string(), do: [c, s]
  end
end
