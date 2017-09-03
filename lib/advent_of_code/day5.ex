defmodule AdventOfCode.Day5 do

  defp contains_at_least_three_vowels(string) do
    string
    |> String.match?(~r/(.*a.*|.*e.*|.*i.*|.*o.*|.*u.*){3}/)
  end

  defp contains_at_least_one_letter_that_appears_twice(string) do
    string
    |> String.match?(~r/(.)\1+/)
  end

  defp contains_the_strings(string) do
    string
    |> String.match?(~r/ab|cd|pq|xy/)
  end

  defp contains_a_pair_of_any_two_letters_that_appears_at_least_twice(string) do
    string
    |> String.match?(~r/([a-z]{2}).*\1+/)
  end

  defp contains_at_least_one_letter_which_repeats_with_exactly_one_letter_between_them(string) do
    string
    |> String.match?(~r/.*([a-z])[^\1]\1+.*)/)
  end

  def is_nice(string) do
    contains_at_least_three_vowels(string) &&
    contains_at_least_one_letter_that_appears_twice(string) &&
    not contains_the_strings(string)
  end

  def are_nice(strings) do
    strings
    |> Enum.map(&(is_nice/1))
  end

  def counters(strings) do
    evaluated_strings = strings |> are_nice
    nice = evaluated_strings |> Enum.count(&(&1))
    naughty = evaluated_strings |> Enum.count(&(not &1))
    [nice: nice, naughty: naughty]
  end

end
