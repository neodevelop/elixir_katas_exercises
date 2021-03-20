defmodule AdventOfCode.Year2016.Day1 do
  def taxicab(instructions) do
    instructions
    |> String.split(", ")
    |> split_instructions()
    |> move_taxi()
    |> IO.inspect()
    |> distance()
  end

  defp split_instructions(instructions) do
    instructions
    |> Enum.map(&extract_instruction/1)
    |> Enum.map(fn [a, b] -> {a, String.to_integer(b)} end)
  end

  defp extract_instruction(instruction) do
    [_, a, b] = Regex.run(~r/(\D)(\d{1,})/, instruction)
    [a, b]
  end

  defp move_taxi(instructions) do
    move_taxi(instructions, {0, 0, :north}, [{0, 0, :north}])
  end

  defp move_taxi([], _point, points), do: points

  defp move_taxi([{to, blocks} | t], {x, y, current_direction}, points) do
    direction = new_direction(to, current_direction)
    vector = increment(x, y, blocks, direction)
    move_taxi(t, vector, points ++ [vector])
  end

  defp new_direction(to, current_direction) do
    case {current_direction, to} do
      {:north, "L"} -> :west
      {:north, "R"} -> :east
      {:east, "L"} -> :north
      {:east, "R"} -> :south
      {:west, "L"} -> :south
      {:west, "R"} -> :north
      {:south, "L"} -> :east
      {:south, "R"} -> :west
    end
  end

  defp increment(x, y, blocks, direction) do
    case direction do
      :north -> {x, y + blocks, direction}
      :south -> {x, y - blocks, direction}
      :west -> {x - blocks, y, direction}
      :east -> {x + blocks, y, direction}
    end
  end

  defp distance(points) do
    {x, y, _} =
      points
      |> List.last()

    abs(x) + abs(y)
  end
end
