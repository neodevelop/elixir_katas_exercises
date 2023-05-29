defmodule AdventOfCode.Day7 do
  def emulate_the_circuit(circuit) do
    circuit
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&split_operations/1)
    |> Enum.map(&transform_single_input/1)
    |> IO.inspect()

    %{}
  end

  defp split_operations(string_operator) do
    string_operator
    |> String.split("->")
    |> Enum.map(&String.trim/1)
  end

  defp transform_single_input([operation, variable] = input) do
    Regex.match?(~r/^\d+$/, operation)
    |> case do
      true -> [String.to_integer(operation), variable]
      false -> input
    end
  end
end
