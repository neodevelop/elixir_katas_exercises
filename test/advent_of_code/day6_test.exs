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

  [
    {{:turn_on, [0, 0], [1, 1]}, 4},
    {{:turn_off, [0, 0], [2, 2]}, 0},
    {{:turn_on, [1, 1], [2, 2]}, 4},
  ] |> Enum.each(fn {instruction, expected_lits} ->

    @instruction instruction
    @expected_lits expected_lits

    test "there are #{expected_lits} lits with the instruction #{inspect instruction}" do
      grid = AdventOfCode.Day6.generate_grid_with_size(3)
      grid = AdventOfCode.Day6.apply_instruction(grid, @instruction)
      lits = AdventOfCode.Day6.count_lits(grid)
      assert lits == @expected_lits
    end

  end)

  [
    {
      %{{0, 0} => 0, {0, 1} => 1, {1, 0} => 1, {1, 1} => 0},
      %{{0, 0} => 1, {0, 1} => 0, {1, 0} => 0, {1, 1} => 1}
    },
  ] |> Enum.each(fn {grid, grid_expected} ->

    @grid grid
    @grid_expected grid_expected

    test "toggle grid #{inspect grid} to #{inspect grid_expected}" do
      instruction = {:toggle, [0, 0], [1, 1]}
      grid_result = AdventOfCode.Day6.apply_instruction(@grid, instruction)
      assert grid_result == @grid_expected
    end

  end)

end
