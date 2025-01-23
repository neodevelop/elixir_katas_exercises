defmodule AdventOfCode.Year2024.Day3 do

  @regex_scanner ~r/mul\((\d+),(\d+)\)/
  @regex_conditional_scanner ~r/mul\((\d+),(\d+)\)|do\(\)|don't\(\)/

  def scan(file) do
    file
    |> File.read!
    |> then(fn corrupted_memory -> 
      Regex.scan(@regex_scanner, corrupted_memory) 
    end)
    |> Enum.map(&extract_and_multiply/1)
    |> Enum.sum()
    |> dbg()
  end

  def scan_conditional(file) do
    file
    |> File.read!
    |> then(fn corrupted_memory -> 
      Regex.scan(@regex_conditional_scanner, corrupted_memory) 
    end)
    |> classify_and_process()
    |> Enum.sum()
    |> dbg()
  end
  
  defp extract_and_multiply([_, x, y]) do
    String.to_integer(x) * String.to_integer(y)
  end

  defp classify_and_process(memory_elements) do
    memory_elements
    |> Enum.reduce(%{mode: :do, operations: []}, fn 
      ["do()"], acc ->
        %{acc | mode: :do}
      ["don't()"], acc ->
        %{acc | mode: :dont}
      operation, %{mode: :do, operations: operations} = acc ->
        %{acc | operations: [extract_and_multiply(operation) | operations]}
      _operation, %{mode: :dont} = acc ->
        acc
    end)
    |> Map.get(:operations)
  end

end
