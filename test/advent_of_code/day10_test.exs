defmodule AdventOfCodeTest.Day10Test do
  use ExUnit.Case

  [
    {"1", "11"},
    {"11", "21"},
    {"21", "1211"},
    {"1211", "111221"},
    {"111221", "312211"}
  ]
  |> Enum.each(fn {input, output} ->
    @input input
    @output output

    test "'#{input}' becomes to '#{output}'" do
      result = AdventOfCode.Day10.look_and_say(@input)
      assert @output == result
    end
  end)
end
