defmodule AdventOfCode.Year2019.Day2Test do
  use ExUnit.Case

  [
    {"1,0,0,0,99", "2,0,0,0,99"}
  ]
  |> Enum.each(fn {input, output} ->
    @input input
    @output output

    test "'#{input}' program runs into '#{output}'" do
      result = AdventOfCode.Year2019.Day2.execute(@input)
      assert @output == result
    end
  end)
end
