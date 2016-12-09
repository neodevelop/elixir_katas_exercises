defmodule StringCalculatorTest do
  use ExUnit.Case
  doctest StringCalculator
  import StringCalculator

  test "the string calculator exists" do
    assert add("") == 0
  end
  test "the string calculator return a number" do
    assert add("1") == 1
    assert add("9") == 9
    assert add("13") == 13
  end
  test "the string calculator evaluates two or more numbers" do
    assert add("1,2") == 3
    assert add("9,10") == 19
    assert add("1,2,3,4") == 10
  end
end
