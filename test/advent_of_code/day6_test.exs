defmodule AdventOfCodeTest.Day6 do
  use ExUnit.Case
  doctest AdventOfCode.Day6

  test "make instructions for 'turn on 0,0 through 999,999'" do
    instruction = "turn on 0,0 through 999,999"
    {action, corner1, corner2} = AdventOfCode.Day6.parse_instruction(instruction)
    assert action == :turn_on
    assert corner1 == [0, 0]
    assert corner2 == [999, 999]

  end

end
