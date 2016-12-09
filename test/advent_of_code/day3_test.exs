defmodule AdventOfCodeTest.Day3 do
  use ExUnit.Case
  doctest AdventOfCode

  test "> delivers presents to 2 houses" do
    assert AdventOfCode.Day3.deliver_gifts(">") == 2
  end

  test "^>v< delivers presents to 4 houses in a square" do
    assert AdventOfCode.Day3.deliver_gifts("^>v<") == 4
  end

  test "^v^v^v^v^v delivers a bunch of presents to some very lucky children at only 2 houses" do
    assert AdventOfCode.Day3.deliver_gifts("^v^v^v^v^v") == 2
  end

  test "^v delivers presents to 3 houses with RoboSanta" do
    assert AdventOfCode.Day3.deliver_gifts_with_robot("^v") == 3
  end

  test "^>v< now delivers presents to 3 houses with RoboSanta" do
    assert AdventOfCode.Day3.deliver_gifts_with_robot("^>v<") == 3
  end

  test "^v^v^v^v^v now delivers presents to 11 houses with RoboSanta" do
    assert AdventOfCode.Day3.deliver_gifts_with_robot("^v^v^v^v^v") == 11
  end
end

