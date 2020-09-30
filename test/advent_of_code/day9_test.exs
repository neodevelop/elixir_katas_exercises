defmodule AdventOfCodeTest.Day9 do
  use ExUnit.Case
  alias AdventOfCode.Day9

  describe "Day 9 Part 1: " do
    test "trace the routes" do
      vertices = [
        {"London", "Dublin", 464},
        {"London", "Belfast", 518},
        {"Dublin", "Belfast", 141}
      ]

      expected_routes = [
        {["Dublin", "London", "Belfast"], 982},
        {["Dublin", "Belfast", "London"], 659},
        {["London", "Dublin", "Belfast"], 605},
        {["London", "Belfast", "Dublin"], 659},
        {["Belfast", "Dublin", "London"], 605},
        {["Belfast", "London", "Dublin"], 982}
      ]

      routes = Day9.trace_routes(vertices)

      assert routes == expected_routes
    end
  end
end
