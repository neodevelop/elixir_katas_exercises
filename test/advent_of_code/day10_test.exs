defmodule AdventOfCodeTest.Day10Test do
  use ExUnit.Case

  test "first step" do
    s = "1211"
    result = AdventOfCode.Day10.process(s)
    assert "111221" == result
  end
end
