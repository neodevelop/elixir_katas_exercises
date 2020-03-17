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
    |> List.to_string
    |> String.codepoints
    |> remove_quotation_marks()
    |> evaluate_char_for_count(0)
  end

  def evaluate_char_for_count([], counter), do: counter
  def evaluate_char_for_count([_ | t], counter) do
    evaluate_char_for_count(t, counter + 1)
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
