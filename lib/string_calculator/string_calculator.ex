defmodule StringCalculator do
  import String, only: :functions

  def add(s) when byte_size(s) == 0 , do: 0
  def add(s) do
    cond do
      starts_with?(s, "//") == true -> evaluate_separators(s)
      true -> s
    end
    |> replace("\n",",")
    |> split(",")
    |> Enum.map(&to_integer(&1))
    |> Enum.reduce(0, fn(x, acc) -> x + acc end)
  end

  defp evaluate_separators(s) do
    s
    |> slice(4..-1)
    |> replace(at(s, 2), ",")
  end

end
