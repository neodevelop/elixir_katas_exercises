defmodule AdventOfCode.Day8 do

  def count_literals_and_memory_for(input) do
    {count_string_literals(input), count_memory_values(input)}
  end

  def count_string_literals(input) do
    input
    |> Enum.count()
  end

  def count_memory_values(input) do
    input
    |> make_the_word("")
    |> String.length()
  end

  def make_the_word([?" | []], word), do: word
  def make_the_word([?" | t], word) when length(t) > 0, do: make_the_word(t, word)
  def make_the_word([c | t], word) when length(t) > 0 do
    make_the_word(t, word <> List.to_string([c]))
  end


end
