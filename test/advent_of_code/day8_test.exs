defmodule AdventOfCodeTest.Day8 do
  use ExUnit.Case
  doctest AdventOfCode.Day8

  describe "Day 8 Part 1: " do
    [
      {~S/""/, {2, 0}},
      {~S/"abc"/, {5, 3}},
      {~S/"aaa\"aaa"/, {10, 7}},
      {~S/"\x27"/, {6, 1}},
      {~S/"axoufpnbx\\ao\x61pfj\"b"/, {25, 18}},
    ] |> Enum.each(fn {input, {string_literals, memory_values}} ->

      @input input
      @string_literals string_literals
      @memory_values memory_values

      test "for input #{@input} the string literlas are #{string_literals} and the memory values are #{memory_values}" do
        {literals, memory} = AdventOfCode.Day8.count_literals_and_memory_for(@input)
        assert literals == @string_literals
        assert memory == @memory_values
      end

    end)

    test "for full input compute the difference between string literals and memory values" do
      input = ~S/""
                 "abc"
                 "aaa\"aaa"
                 "\x27"/
      assert AdventOfCode.Day8.differences_of(input) == 12
    end
  end

  describe "Day 8 Part 2: " do
    [
      {~S/""/, {6, 2}},
      {~S/"abc"/, {9, 5}},
      {~S/"aaa\"aaa"/, {16, 10}},
      {~S/"\x27"/, {11, 6}},
      #{~S/"axoufpnbx\\ao\x61pfj\"b"/, {25, 18}},
    ] |> Enum.each(fn {input, {encoded_length, string_literals}} ->

      @input input
      @encoded_length encoded_length
      @string_literals string_literals

      test "for input #{@input} the encoded string length is #{encoded_length} and the memory values are #{string_literals}" do
        {encoded, literals} = AdventOfCode.Day8.count_encoded_and_literals_for(@input)
        assert encoded == @encoded_length
        assert literals == @string_literals
      end

    end)

    test "for full input compute the difference between string encoded and literals" do
      input = ~S/""
                 "abc"
                 "aaa\"aaa"
                 "\x27"/
      assert AdventOfCode.Day8.differences_encoded_of(input) == 19
    end
  end

end
