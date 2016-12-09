defmodule StringCalculatorTest do
  use ExUnit.Case
  doctest StringCalculator

  test "the string calculator exists" do
    assert StringCalculator.add("") == 0
   end
 end
