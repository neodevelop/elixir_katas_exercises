defmodule StringCalculator do
  def add(s) when byte_size(s) == 0 , do: 0
  s |> String.split(",")
  |> Enum.map(&String.to_integer(&1))
  |> Enum.reduce(0, fn(x, acc) -> x + acc end)
  end
end
