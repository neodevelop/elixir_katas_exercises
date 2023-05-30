defmodule AdventOfCode.Day7 do
  @limit Float.pow(2.0, 16) |> trunc()

  def emulate_the_circuit(circuit) do
    circuit
    |> circuit_in_operators()
    |> apply_operations()
  end

  defp circuit_in_operators(circuit) do
    circuit
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&split_operations/1)
    |> Enum.map(&transform_operations/1)
  end

  defp split_operations(string_operator) do
    string_operator
    |> String.split("->")
    |> Enum.map(&String.trim/1)
  end

  defp transform_operations([operation, variable]) do
    [String.split(operation, " "), variable]
  end

  defp apply_operations(operations) do
    apply_operations(operations, operations, %{})
  end

  defp apply_operations([], operations, values) do
    case Enum.count(operations) == Enum.count(values) do
      true -> values
      false -> apply_operations(operations, operations, values)
    end
  end

  defp apply_operations([[operation, var] | rest], operations, values) do
    result = apply_single_operation(operation, values)

    case is_integer(result) do
      true ->
        apply_operations(rest, operations, Map.put(values, var, result))

      false ->
        apply_operations(rest, operations, values)
    end
  end

  defp apply_single_operation([v], values) do
    case Regex.match?(~r/^\d+$/, v) do
      true ->
        String.to_integer(v)

      false ->
        case Map.get(values, v) do
          nil -> v
          e -> e
        end
    end
  end

  defp apply_single_operation([operand, a] = operation, values) do
    case Map.has_key?(values, a) do
      true -> exec_operation(operand, a, values)
      false -> operation
    end
  end

  defp apply_single_operation([a, operand, b] = operation, values)
       when operand in ["AND", "OR"] do
    case Map.has_key?(values, a) and Map.has_key?(values, b) do
      true -> exec_operation(a, operand, b, values)
      false -> operation
    end
  end

  defp apply_single_operation([a, operand, b] = operation, values)
       when operand in ["LSHIFT", "RSHIFT"] do
    case Map.has_key?(values, a) do
      true -> exec_operation(a, operand, b, values)
      false -> operation
    end
  end

  defp apply_single_operation(operation, _values) do
    operation
  end

  defp exec_operation("NOT", v, values) do
    values
    |> Map.get(v)
    |> Bitwise.bnot()
    |> Kernel.+(@limit)
  end

  defp exec_operation(a, "AND", b, values) do
    value_a = Map.get(values, a)
    value_b = Map.get(values, b)
    Bitwise.band(value_a, value_b)
  end

  defp exec_operation(a, "OR", b, values) do
    value_a = Map.get(values, a)
    value_b = Map.get(values, b)
    Bitwise.bor(value_a, value_b)
  end

  defp exec_operation(a, "LSHIFT", b, values) do
    value_a = Map.get(values, a)
    value_b = String.to_integer(b)
    Bitwise.bsl(value_a, value_b)
  end

  defp exec_operation(a, "RSHIFT", b, values) do
    value_a = Map.get(values, a)
    value_b = String.to_integer(b)
    Bitwise.bsr(value_a, value_b)
  end
end
