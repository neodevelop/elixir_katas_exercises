defmodule AdventOfCode.Day7 do
  @limit Float.pow(2.0, 16) |> trunc()

  def emulate_the_circuit(circuit) do
    signals =
      circuit
      |> circuit_in_operators()
      |> Enum.filter(&get_single_values/1)

    initial_values =
      for [value, variable] <- signals,
          into: %{},
          do: {variable, value}

    circuit
    |> circuit_in_operators()
    |> Enum.filter(&get_operations/1)
    |> apply_operations(initial_values)
  end

  defp circuit_in_operators(circuit) do
    circuit
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&split_operations/1)
    |> Enum.map(&transform_single_input/1)
    |> Enum.map(&transform_operations/1)
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

  defp transform_operations([operation, _] = input) when is_integer(operation), do: input

  defp transform_operations([operation, variable]) do
    [String.split(operation, " "), variable]
  end

  defp get_single_values([v, _]) when is_integer(v), do: true
  defp get_single_values(_), do: false

  defp get_operations([v, _]) when is_integer(v), do: false
  defp get_operations(_), do: true

  defp apply_operations([], values), do: values

  defp apply_operations([[operation, var] | rest], values) do
    result = apply_single_operation(operation, values)
    apply_operations(rest, Map.put(values, var, result))
  end

  defp apply_single_operation(["NOT", v], values) do
    values
    |> Map.get(v)
    |> Bitwise.bnot()
    |> Kernel.+(@limit)
  end

  defp apply_single_operation([a, "AND", b], values) do
    value_a = Map.get(values, a)
    value_b = Map.get(values, b)
    Bitwise.band(value_a, value_b)
  end

  defp apply_single_operation([a, "OR", b], values) do
    value_a = Map.get(values, a)
    value_b = Map.get(values, b)
    Bitwise.bor(value_a, value_b)
  end

  defp apply_single_operation([a, "LSHIFT", b], values) do
    value_a = Map.get(values, a)
    value_b = String.to_integer(b)
    Bitwise.bsl(value_a, value_b)
  end

  defp apply_single_operation([a, "RSHIFT", b], values) do
    value_a = Map.get(values, a)
    value_b = String.to_integer(b)
    Bitwise.bsr(value_a, value_b)
  end

  defp apply_single_operation(operation, _values) do
    operation
  end
end
