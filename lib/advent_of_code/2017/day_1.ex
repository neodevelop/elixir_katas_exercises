defmodule AdventOfCode.Year2017.Day1 do
  def sum_chain(chain) do
    chain
    |> String.split("", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_while(
      [],
      fn
        element, [] ->
          {:cont, [element]}

        element, [element] = acc ->
          {:cont, [element | acc]}

        element, [element, element] = acc ->
          {:cont, acc, acc}

        element, acc ->
          {:cont, acc, [element]}
      end,
      fn
        [] -> {:cont, []}
        acc -> {:cont, Enum.reverse(acc), []}
      end
    )
    |> Enum.filter(&(Enum.count(&1) > 1))
    |> Enum.map(fn [e, e] -> e end)
    |> Enum.sum()
  end
end
