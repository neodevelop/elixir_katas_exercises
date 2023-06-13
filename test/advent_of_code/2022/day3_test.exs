defmodule AdventOfCode.Year2022.Day3Test do
  use ExUnit.Case

  alias AdventOfCode.Year2022.Day3

  @rucksacks """
  vJrwpWtwJgWrhcsFMMfFFhFp
  jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
  PmmdzqPrVvPwwTWBwg
  wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
  ttgJtRGJQctTZtZT
  CrZsJsPPZsGzwwsLwLmpwMDw
  """

  test "sum the priorities of rucksacks" do
    assert Day3.prioritize(@rucksacks) |> Enum.sum() == 157
  end

  test "sum the priorities of groups of rucksacks" do
    assert Day3.prioritize_groups(@rucksacks) |> Enum.sum() == 70
  end
end
