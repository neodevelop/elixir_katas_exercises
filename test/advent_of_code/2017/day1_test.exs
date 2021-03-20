defmodule AdventOfCode.Year2017.Day1Test do
  use ExUnit.Case
  alias AdventOfCode.Year2016.Day1

  test "distance in blocks for taxicab" do
    instructions = "R2, L3"
    result = Day1.taxicab(instructions)
    assert result == 5
  end

  test "distance 2 in blocks for taxicab" do
    instructions = "R2, R2, R2"
    result = Day1.taxicab(instructions)
    assert result == 2
  end

  test "distance 3 in blocks for taxicab" do
    instructions = "R5, L5, R5, R3"
    result = Day1.taxicab(instructions)
    assert result == 12
  end
end
