defmodule AdventOfCode.Year2020.Day2 do

  @split_rules ~r/(\d+)-(\d+) (.+): (\w+)/

  def how_many_valids_and_invalids(password_rules) do
    password_rules
    |> validate_passwords()
    |> count_valids_and_invalids()
  end

  def how_many_valids_and_invalids_and_enforce(password_rules) do
    password_rules
    |> validate_passwords_enforce()
    |> count_valids_and_invalids()
  end

  def validate_passwords_enforce(password_rules) do
    password_rules
    |> String.split("\n")
    |> Enum.filter(fn s -> String.length(s) > 0 end)
    |> Enum.map(&validate_password_enforce/1)
  end

  def validate_passwords(password_rules) do
    password_rules
    |> String.split("\n")
    |> Enum.filter(fn s -> String.length(s) > 0 end)
    |> Enum.map(&validate_password/1)
  end

  def validate_password(password_rules) do
    @split_rules
    |> Regex.run(password_rules)
    |> set_limits()
    |> apply_rules()
  end

  def validate_password_enforce(password_rules) do
    @split_rules
    |> Regex.run(password_rules)
    |> set_limits()
    |> apply_rules_enforced()
  end

  defp set_limits([_, min, max, letter, phrase]) do
    {String.to_integer(min), String.to_integer(max), letter, phrase}
  end

  defp apply_rules({min, max, letter, phrase}) do
    phrase
    |> String.split("")
    |> Enum.count(fn e -> e == letter end)
    |> count_ocurrences(min, max)
  end

  defp apply_rules_enforced({pos_1, pos_2, letter, phrase}) do
    list = phrase
    |> String.split("")

    match_ocurrences(Enum.fetch!(list, pos_1), Enum.fetch!(list, pos_2), letter)
  end

  defp count_ocurrences(counter, min,max) when min <= counter and counter <= max, do: :valid
  defp count_ocurrences(_, _, _), do: :invalid

  defp count_valids_and_invalids(results) do
    %{
      valid: results |> Enum.filter(fn e -> e == :valid end) |> Enum.count(),
      invalid: results |> Enum.filter(fn e -> e == :invalid end) |> Enum.count(),
    }
  end

  defp match_ocurrences(a, a, a), do: :invalid
  defp match_ocurrences(_, a, a), do: :valid
  defp match_ocurrences(a, _, a), do: :valid
  defp match_ocurrences(_, _, _), do: :invalid

end
