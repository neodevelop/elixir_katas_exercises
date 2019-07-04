defmodule AdventOfCodeTest.Day6 do
  use ExUnit.Case
  doctest AdventOfCode.Day6

  [
    {"turn on 0,0 through 999,999", {:turn_on, [0, 0], [999, 999]}},
    {"toggle 0,0 through 999,0", {:toggle, [0, 0], [999, 0]}},
    {"turn off 499,499 through 500,500", {:turn_off, [499, 499], [500, 500]}},
  ] |> Enum.each(fn {instruction, {expected_action, expected_corner_1, expected_corner_2}} ->

    @instruction instruction
    @expected_action expected_action
    @expected_corner_1 expected_corner_1
    @expected_corner_2 expected_corner_2

    test "make instructions for '#{@instruction}'" do
      {action, corner1, corner2} = AdventOfCode.Day6.parse_instruction(@instruction)
      assert action == @expected_action
      assert corner1 == @expected_corner_1
      assert corner2 == @expected_corner_2
    end

  end)

end
