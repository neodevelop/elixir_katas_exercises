defmodule StringCalculatorTest do
  use ExUnit.Case
  doctest StringCalculator

  test "the string calculator exists" do
    assert StringCalculator.add("") == 0
  end

  test "the string calculator return a number" do
    assert StringCalculator.add("1") == 1
    assert StringCalculator.add("9") == 9
    assert StringCalculator.add("13") == 13
  end
end
