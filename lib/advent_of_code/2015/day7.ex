defmodule AdventOfCode.Day7 do
  @limit Float.pow(2.0, 16) |> trunc()
  @is_number ~r/^\d+$/

  def emulate_the_circuit(circuit) do
    circuit
    |> circuit_in_operators()
    |> build_circuit()
  end

  defp circuit_in_operators(circuit) do
    circuit
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&split_operations/1)
    |> Enum.map(&transform_operations/1)
    |> Enum.map(&transform_numbers/1)
  end

  defp split_operations(string_operator) do
    string_operator
    |> String.split("->")
    |> Enum.map(&String.trim/1)
  end

  defp transform_operations([operation, variable]) do
    [String.split(operation, " "), variable]
  end

  defp transform_numbers([operators, variable]) do
    new_operators =
      operators
      |> Enum.map(fn e ->
        case String.match?(e, @is_number) do
          true -> String.to_integer(e)
          false -> e
        end
      end)

    [new_operators, variable]
  end

  defp build_circuit(operations) do
    build_circuit(operations, operations, %{})
  end

  defp build_circuit([], operations, circuit) do
    case Enum.count(operations) == Enum.count(circuit) do
      true -> circuit
      false -> build_circuit(operations, operations, circuit)
    end
  end

  defp build_circuit([operation | rest], operations, circuit) do
    new_circuit = wire(operation, operations, circuit)

    build_circuit(rest, operations, new_circuit)
  end

  defp wire([[op_1, operator, op_2], variable], operations, circuit)
       when is_binary(op_1) do
    circuit
    |> Map.get(op_1)
    |> case do
      nil ->
        case String.match?(op_1, @is_number) do
          true ->
            [[String.to_integer(op_1), operator, op_2], variable]

          false ->
            Enum.find(operations, fn [_, v] -> op_1 == v end)
        end

      value_op_1 ->
        [[value_op_1, operator, op_2], variable]
    end
    |> wire(operations, circuit)
  end

  defp wire([[op_1, operator, op_2], variable], operations, circuit)
       when is_binary(op_2) do
    case Map.has_key?(circuit, op_2) do
      true ->
        [[op_1, operator, Map.get(circuit, op_2)], variable]

      false ->
        case String.match?(op_2, @is_number) do
          true ->
            [[op_1, operator, String.to_integer(op_2)], variable]

          false ->
            operations
            |> Enum.find(fn [_, v] -> op_2 == v end)
        end
    end
    |> wire(operations, circuit)
  end

  defp wire([[operator, op], variable], operations, circuit) when is_binary(op) do
    case Map.has_key?(circuit, op) do
      true ->
        [[operator, Map.get(circuit, op)], variable]

      false ->
        case String.match?(op, @is_number) do
          true ->
            [[operator, String.to_integer(op)], variable]

          false ->
            operations
            |> Enum.find(fn [_, v] -> op == v end)
        end
    end
    |> wire(operations, circuit)
  end

  defp wire([[operation], variable], operations, circuit) when is_binary(operation) do
    case Map.has_key?(circuit, operation) do
      true ->
        circuit
        |> Map.put(variable, Map.get(circuit, operation))

      false ->
        case String.match?(operation, @is_number) do
          true ->
            circuit
            |> Map.put(variable, Map.get(circuit, operation))

          false ->
            operations
            |> Enum.find(fn [_, v] -> operation == v end)
            |> wire(operations, circuit)
        end
    end
  end

  defp wire([[op_1, operator, op_2], variable], _operations, circuit)
       when is_integer(op_1) and is_integer(op_2) do
    circuit
    |> Map.put(variable, exec_operation(op_1, operator, op_2))
  end

  defp wire([[operator, op], variable], _operations, circuit)
       when is_integer(op) do
    circuit
    |> Map.put(variable, exec_operation(operator, op))
  end

  defp wire([[operator], variable], _operations, circuit) when is_integer(operator) do
    circuit
    |> Map.put(variable, operator)
  end

  defp exec_operation(a, "AND", b), do: Bitwise.band(a, b)
  defp exec_operation(a, "OR", b), do: Bitwise.bor(a, b)
  defp exec_operation(a, "LSHIFT", b), do: Bitwise.bsl(a, b)
  defp exec_operation(a, "RSHIFT", b), do: Bitwise.bsr(a, b)

  defp exec_operation("NOT", v),
    do:
      v
      |> Bitwise.bnot()
      |> Kernel.+(@limit)
end
