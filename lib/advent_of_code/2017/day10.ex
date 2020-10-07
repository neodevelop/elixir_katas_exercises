defmodule AdventOfCode.Day10 do
  def make_list(s) do
    s |> String.split("") |> Enum.filter(&(&1 != ""))
  end

  def process(s) do
    s
    |> make_list()
    |> look_and_say()

    # |> Enum.join("")
  end

  defp look_and_say([h | t]) do
    t
    |> process(h, [])
  end

  def process([], _c, groups), do: groups

  def process(chars, c, groups) do
    IO.inspect(c)
    {new_chars, group, new_char} = group_chars(c, chars, [])
    process(new_chars, new_char, [group | groups])
  end

  defp group_chars(c, [], group), do: {[], [c | group], c}

  defp group_chars(c, [h | t] = _chars, group) do
    case String.equivalent?(c, h) do
      true ->
        group_chars(h, t, [h | group])

      false ->
        {t, [c | group], h}
    end
  end
end
