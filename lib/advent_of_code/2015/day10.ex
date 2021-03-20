defmodule AdventOfCode.Day10 do
  def look_and_say(word, n \\ 1)
  def look_and_say(word, 0), do: word

  def look_and_say(word, n) do
    word
    |> make_list()
    |> process()
    |> Enum.reverse()
    |> count_uniques()
    |> Enum.join()
    |> look_and_say(n - 1)
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

  def group([], c, groups) do
    if groups == [] do
      [[c]]
    else
      [h | _] = groups

      case Enum.all?(h, fn e -> String.equivalent?(e, c) end) do
        true ->
          groups

        false ->
          [[c]] ++ groups
      end
    end
  end

  def group(chars, c, groups) do
    {new_chars, group, new_char} = group_chars(c, chars, [])
    group(new_chars, new_char, [group | groups])
  end

  defp group_chars(c, [], group) do
    {[], [c | group], c}
  end

  defp group_chars(c, [h | t] = _chars, group) do
    case String.equivalent?(c, h) do
      true ->
        group_chars(h, t, [h | group])

      false ->
        {t, [c | group], h}
    end
  end

  defp count_uniques(groups) do
    for u <- groups, [s | _] = u, c = Enum.count(u) |> Integer.to_string(), do: [c, s]
  end
end
