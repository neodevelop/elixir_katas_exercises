defmodule AdventOfCodeTest.Day8 do
  use ExUnit.Case
  doctest AdventOfCode.Day8

  [
    {'""', {2, 0}},
    {'"abc"', {5, 3}},
    {'"aaa\"aaa"', {10, 7}},
  ] |> Enum.each(fn {input, {string_literals, memory_values}} ->

    @input input
    @string_literals string_literals
    @memory_values memory_values

    test "for input '#{@input}' the string literlas are #{string_literals} and the memory values are #{memory_values}" do
      {literals, memory} = AdventOfCode.Day8.count_literals_and_memory_for(@input)
      assert literals == @string_literals
      assert memory == @memory_values
    end

  end)

end
