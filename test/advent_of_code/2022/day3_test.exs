defmodule AdventOfCode.Year2022.Day3Test do
  use ExUnit.Case

  test "sum the priorities of rucksacks" do
    rucksacks = """
    vJrwpWtwJgWrhcsFMMfFFhFp
    jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
    PmmdzqPrVvPwwTWBwg
    wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
    ttgJtRGJQctTZtZT
    CrZsJsPPZsGzwwsLwLmpwMDw
    """

    assert AdventOfCode.Year2022.Day3.prioritize(rucksacks) |> Enum.sum() == 157
  end
end
