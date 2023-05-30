defmodule AdventOfCodeTest.Day7Test do
  use ExUnit.Case

  alias AdventOfCode.Day7

  describe "Day 7 Part 1: " do
    test "run the circuit" do
      circuit = """
      123 -> x
      456 -> y
      x AND y -> d
      x OR y -> e
      x LSHIFT 2 -> f
      y RSHIFT 2 -> g
      NOT x -> h
      NOT y -> i
      """

      signals_on_wires = Day7.emulate_the_circuit(circuit)

      expected_signals = %{
        "d" => 72,
        "e" => 507,
        "f" => 492,
        "g" => 114,
        "h" => 65412,
        "i" => 65079,
        "x" => 123,
        "y" => 456
      }

      assert expected_signals == signals_on_wires
    end

    test "run the circuit with anon vars" do
      circuit = """
      d AND e -> a
      a -> z
      123 -> x
      456 -> y
      x AND y -> d
      x OR y -> e
      x LSHIFT 2 -> f
      y RSHIFT 2 -> g
      NOT x -> h
      NOT y -> i
      """

      signals_on_wires = Day7.emulate_the_circuit(circuit)

      expected_signals = %{
        "d" => 72,
        "e" => 507,
        "f" => 492,
        "g" => 114,
        "h" => 65412,
        "i" => 65079,
        "x" => 123,
        "y" => 456,
        "a" => 72,
        "z" => 72
      }

      assert expected_signals == signals_on_wires
    end
  end
end
