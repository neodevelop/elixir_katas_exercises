defmodule AdventOfCode.Year2020.Day3Test do
  use ExUnit.Case

  setup do
    %{
      path:
      """
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
    }
  end

  test "find the trees in the path", %{path: path} do
    trees = AdventOfCode.Year2020.Day3.walk(path)
    assert trees == 7
  end

  test "find the trees in multiple paths", %{path: path} do
    slopes = [{1, 1}, {3, 1}, {5, 1}, {7, 1}, {1, 2}]

    trees = AdventOfCode.Year2020.Day3.multiple_walk(path, slopes)
    assert trees == [2, 7, 3, 4, 2]
  end

end

