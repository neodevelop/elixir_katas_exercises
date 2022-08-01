defmodule AdventOfCode.Year2020.Day2Test do
  use ExUnit.Case

  [
    {"1-3 a: abcde", :valid},
    {"1-3 b: cdefg", :invalid},
    {"2-9 c: ccccccccc", :valid},
  ]
  |> Enum.each(fn {password_rules, validation} ->
    @password_rules password_rules
    @validation validation

    test "the policiy '#{password_rules}' is '#{validation}'" do
      result = AdventOfCode.Year2020.Day2.validate_password(@password_rules)
      assert @validation == result
    end
  end)

  [
    {"1-3 a: abcde", :valid},
    {"1-3 b: cdefg", :invalid},
    {"2-9 c: ccccccccc", :invalid},
  ]
  |> Enum.each(fn {password_rules, validation} ->
    @password_rules password_rules
    @validation validation

    test "the enforce policy '#{password_rules}' is '#{validation}'" do
      result = AdventOfCode.Year2020.Day2.validate_password_enforce(@password_rules)
      assert @validation == result
    end
  end)

end
