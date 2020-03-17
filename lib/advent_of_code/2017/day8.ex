defmodule AdventOfCode.Day8 do

  def count_literals_and_memory_for(input) do
    {count_string_literals(input), count_memory_values(input)}
  end

  def count_string_literals(input) do
    input
    |> remove_quotation_marks()
    |> count_chars(2) # Because quotation
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

  def remove_quotation_marks(input) do
    input
    |> Enum.drop(1)
    |> Enum.reverse()
    |> Enum.drop(1)
  end

  def count_chars([], counter), do: counter
  def count_chars([?" | t], counter), do: count_chars(t, counter + 2)
  def count_chars([_ | t], counter), do: count_chars(t, counter + 1)

end
