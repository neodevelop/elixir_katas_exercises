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

  defp apply_operations(operations) do
    apply_operations(operations, operations, %{})
  end

  defp apply_operations([], _operations, values), do: values

  defp apply_operations([operation | rest], operations, values) do
    apply_single_operation(operation, operations, values)

    apply_operations(rest, operations, values)
  end

  defp apply_single_operation([[operator], var], _operations, values)
       when is_integer(operator) do
    values
    |> Map.put(var, operator)
    |> IO.inspect(label: "Single value")
  end

  defp apply_single_operation([[operation], variable], operations, values) do
    IO.inspect(binding(), label: "single value")

    case String.match?(operation, @is_number) do
      true ->
        [[String.to_integer(operation)], variable]
        |> apply_single_operation(operations, values)

      false ->
        operations
        |> Enum.find(fn [_, v] -> operation == v end)
        |> IO.inspect()
        |> apply_single_operation(operations, values)
    end
  end

  defp apply_single_operation([[operator, op], var], _operations, values)
       when is_integer(op) do
    values
    |> Map.put(var, exec_operation(operator, op))
  end

  defp apply_single_operation([[operator, op], variable], operations, values) do
    case String.match?(op, @is_number) do
      true ->
        [[operator, String.to_integer(op)], variable]
        |> apply_single_operation(operations, values)

      false ->
        operations
        |> Enum.find(fn [_, v] -> op == v end)
        |> IO.inspect()
        |> apply_single_operation(operations, values)
    end
  end

  defp apply_single_operation([[op_1, operator, op_2], variable], operations, values)
       when is_binary(op_1) do
    case String.match?(op_1, @is_number) do
      true ->
        [[String.to_integer(op_1), operator, op_2], variable]
        |> apply_single_operation(operations, values)

      false ->
        operations
        |> Enum.find(fn [_, v] -> op_1 == v end)
        |> IO.inspect()
        |> apply_single_operation(operations, values)
    end
  end

  defp apply_single_operation([[op_1, operator, op_2], variable], operations, values)
       when is_binary(op_2) do
    case String.match?(op_2, @is_number) do
      true ->
        [[op_1, operator, String.to_integer(op_2)], variable]
        |> apply_single_operation(operations, values)

      false ->
        operations
        |> Enum.find(fn [_, v] -> op_2 == v end)
        |> IO.inspect()
        |> apply_single_operation(operations, values)
    end
  end

  defp apply_single_operation([[op_1, operator, op_2], var], _operations, values)
       when is_integer(op_1) and is_integer(op_2) do
    values
    |> Map.put(var, exec_operation(op_1, operator, op_2))
  end

  defp apply_single_operation([_, variable], operations, values) do
    operations
    |> Enum.find(fn [_, v] -> variable == v end)
    |> apply_single_operation(operations, values)
  end

  # defp apply_operations([], operations, values) do
  #   case Enum.count(operations) == Enum.count(values) do
  #     true -> values
  #     false -> apply_operations(operations, operations, values)
  #   end
  # end

  # defp apply_operations([[operation, var] | rest], operations, values) do
  #   result = apply_single_operation(operation, values)

  #   case is_integer(result) do
  #     true ->
  #       apply_operations(rest, operations, Map.put(values, var, result))

  #     false ->
  #       apply_operations(rest, operations, values)
  #   end
  # end

  # defp apply_single_operation([v], values) do
  #   case Regex.match?(~r/^\d+$/, v) do
  #     true ->
  #       String.to_integer(v)

  #     false ->
  #       case Map.get(values, v) do
  #         nil -> v
  #         e -> e
  #       end
  #   end
  # end

  # defp apply_single_operation([operand, a] = operation, values) do
  #   case Map.has_key?(values, a) do
  #     true -> exec_operation(operand, a, values)
  #     false -> operation
  #   end
  # end

  # defp apply_single_operation([a, operand, b] = operation, values)
  #      when operand in ["AND", "OR"] do
  #   case Map.has_key?(values, a) and Map.has_key?(values, b) do
  #     true -> exec_operation(a, operand, b, values)
  #     false -> operation
  #   end
  # end

  # defp apply_single_operation([a, operand, b] = operation, values)
  #      when operand in ["LSHIFT", "RSHIFT"] do
  #   case Map.has_key?(values, a) do
  #     true -> exec_operation(a, operand, b, values)
  #     false -> operation
  #   end
  # end

  # defp apply_single_operation(operation, _values) do
  #   operation
  # end

  defp exec_operation("NOT", v),
    do:
      v
      |> Bitwise.bnot()
      |> Kernel.+(@limit)

  defp exec_operation(a, "AND", b), do: Bitwise.band(a, b)
  defp exec_operation(a, "OR", b), do: Bitwise.bor(a, b)
  defp exec_operation(a, "LSHIFT", b), do: Bitwise.bsl(a, b)
  defp exec_operation(a, "RSHIFT", b), do: Bitwise.bsr(a, b)
end
