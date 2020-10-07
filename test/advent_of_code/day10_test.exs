defmodule AdventOfCodeTest.Day10Test do
  use ExUnit.Case

  test "zero step" do
    s = "1"
    result = AdventOfCode.Day10.look_and_say(s)
    assert "11" == result
  end

  test "first step" do
    s = "1211"
    result = AdventOfCode.Day10.look_and_say(s)
    assert "111221" == result
  end

  test "second step" do
    s = "111221"
    result = AdventOfCode.Day10.look_and_say(s)
    assert "312211" == result
  end
end
