defmodule StringCalculator do
  def add(s) when byte_size(s) == 0 , do: 0
  if String.starts_with? s, "//" do
    s
    |> evaluate_separators
    |> String.replace("\n",",")
    |> String.split(",")
    |> Enum.map(&String.to_integer(&1))
    |> Enum.reduce(0, fn(x, acc) -> x + acc end)
  else
    s
    |> String.replace("\n",",")
    |> String.split(",")
    |> Enum.map(&String.to_integer(&1))
    |> Enum.reduce(0, fn(x, acc) -> x + acc end)
  end
end

defp evaluate_separators(s) do
  separator = String.at s, 2
  s
  |> String.slice(4..-1)
  |> String.replace(separator, ",")

end
end
