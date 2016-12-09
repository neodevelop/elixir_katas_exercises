defmodule StringCalculator do
  import String, only: :functions

  def add(s) when byte_size(s) == 0 , do: 0
  def add(s) do
    if starts_with? s, "//" do
      s
      |> evaluate_separators
      |> replace("\n",",")
      |> split(",")
      |> Enum.map(&to_integer(&1))
      |> Enum.reduce(0, fn(x, acc) -> x + acc end)
    else
      s
      |> replace("\n",",")
      |> split(",")
      |> Enum.map(&to_integer(&1))
      |> Enum.reduce(0, fn(x, acc) -> x + acc end)
    end
  end

  defp evaluate_separators(s) do
    s
    |> slice(4..-1)
    |> replace(at(s, 2), ",")
  end

end
