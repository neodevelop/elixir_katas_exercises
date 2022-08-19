defmodule AdventOfCode.Year2017.Day1 do
  def sum_chain(chain) do
    chain
    |> get_numbers_from_chain()
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
    |> circular_list(chain)
    |> Enum.filter(&(Enum.count(&1) > 1))
    |> Enum.map(fn [e, e] -> e end)
    |> Enum.sum()
  end

  def sum_split_chain(chain) do
    chain
    |> get_numbers_from_chain()
    |> split_half_chain()
    |> compare_chains(0)
  end

  defp circular_list(acc, chain) do
    c = get_numbers_from_chain(chain)
    apply_circular_list(List.first(c), List.last(c), acc)
  end

  defp apply_circular_list(e, e, acc), do: acc ++ [[e, e]]
  defp apply_circular_list(_, _, acc), do: acc

  defp get_numbers_from_chain(chain),
    do:
      chain
      |> String.split("", trim: true)
      |> Enum.map(&String.to_integer/1)

  defp split_half_chain(chain) do
    half = chain |> Enum.count() |> Kernel./(2) |> floor()

    {chain |> Enum.take(half), chain |> Enum.take(-1 * half)}
  end

  defp compare_chains({[], _}, sum), do: sum

  defp compare_chains({[h | t1], [h | t2]}, sum) do
    compare_chains({t1, t2}, sum + h + h)
  end

  defp compare_chains({[_ | t1], [_ | t2]}, sum) do
    compare_chains({t1, t2}, sum)
  end
end
