defmodule AdventOfCode.Year2020.Day3Test do
  use ExUnit.Case

  test "find the trees in the path" do
    path = """
		..##.......
		#...#...#..
		.#....#..#.
		..#.#...#.#
		.#...##..#.
		..#.##.....
		.#.#.#....#
		.#........#
		#.##...#...
		#...##....#
		.#..#...#.#
    """

    trees = AdventOfCode.Year2020.Day3.walk(path)
    assert trees == 7
  end


end

