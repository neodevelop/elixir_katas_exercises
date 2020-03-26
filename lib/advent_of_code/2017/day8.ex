defmodule AdventOfCode.Day8 do

  def differences_of(input) do
    input
    |> String.split("\n")
    |> Enum.map(&(String.trim(&1)))
    |> Enum.map(&(count_literals_and_memory_for/1))
    |> compute_differences()
  end

  def compute_differences(list_of_tuples) do
    (for {x,y} <- list_of_tuples, do: x-y) |> Enum.sum
  end

  def count_literals_and_memory_for(input) do
    {count_string_literals(input), count_memory_values(input)}
  end

  def count_string_literals(input) do
    input
    |> String.split("")
    |> remove_quotation_marks()
    |> remove_quotation_marks()
    |> count_chars(2) # Because quotation
  end

  def count_memory_values(input) do
    input
    |> String.split("")
    |> remove_quotation_marks()
    |> remove_quotation_marks()
    |> evaluate_char_for_count(0)
  end

  def evaluate_char_for_count([], counter), do: counter
  def evaluate_char_for_count(["\\", "x", _, _ | t], counter) do
    evaluate_char_for_count(t, counter + 1)
  end
  def evaluate_char_for_count(["\\", _ | t], counter) do
    evaluate_char_for_count(t, counter + 1)
  end
  def evaluate_char_for_count(["\\" | t], counter) do
    evaluate_char_for_count(t, counter)
  end
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
  def count_chars(["\"" | t], counter), do: count_chars(t, counter + 1)
  def count_chars(["\\\\" | t], counter), do: count_chars(t, counter)
  def count_chars([_ | t], counter), do: count_chars(t, counter + 1)

end
