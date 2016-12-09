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

  test "the string calculator supports new line as separator" do
    assert add("1\n2") == 3
    assert add("9\n10") == 19
    assert add("1\n2,3,4") == 10
  end
  test "the string calculator supports any custom separator" do
    assert add("//;\n1;2;3;4") == 10
    assert add("//$\n1$2$3$4$5") == 15
    assert add("//#\n1#2#3#4#5#6") == 21
  end

  test "the string calculator raise an error with negative numbers" do
    assert_raise ArgumentError, "negatives not allowed -2 -4 -6", fn ->
      add("//#\n1#-2#3#-4#5#-6")
    end
  end

end
