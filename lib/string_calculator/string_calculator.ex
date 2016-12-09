defmodule StringCalculator do
  import String, only: :functions

  def add(""), do: 0
  def add(s) do
    s
    |> handle_the_separator
    |> replace("\n",",")
    |> split(",")
    |> Enum.map(&to_integer(&1))
    |> throw_error_with_negative_numbers
    |> Enum.reduce(0, fn(x, acc) -> x + acc end)
  end

  defp handle_the_separator(<< "//", separator :: binary-size(1), "\n", rest :: binary >>) do
    rest
    |> replace(separator, ",")
  end

  defp handle_the_separator(s), do: s

  defp throw_error_with_negative_numbers(list) do
    negatives = Enum.filter(list, &(&1 < 0))
    unless Enum.empty?(negatives) do
      raise ArgumentError, "negatives not allowed " <> Enum.join(negatives," ")
    end
    list
  end

end
