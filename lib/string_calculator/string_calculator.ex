defmodule StringCalculator do
  import String, only: :functions

  def add(""), do: 0
  def add(s) do
    s
    |> handle_the_separator
    |> replace("\n",",")
    |> split(",")
    |> Enum.map(&to_integer(&1))
    |> get_negatives
    |> handle_tuple_with_numbers
  end

  defp handle_the_separator(<< "//", separator :: binary-size(1), "\n", rest :: binary >>) do
    rest
    |> replace(separator, ",")
  end

  defp handle_the_separator(s), do: s

  defp get_negatives(list) do
    { list, Enum.filter(list, &(&1 < 0)) }
  end

  defp handle_tuple_with_numbers({list, []}) do
    list |> Enum.reduce(0, fn(x, acc) -> x + acc end)
  end

  defp handle_tuple_with_numbers({_, negatives}) do
    raise ArgumentError, "negatives not allowed " <> Enum.join(negatives," ")
  end

end
