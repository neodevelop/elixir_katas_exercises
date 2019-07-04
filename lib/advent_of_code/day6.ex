defmodule AdventOfCode.Day6 do

  def raw_instructions_from_file(filename) do
    filename
    |> File.read!
    |> String.trim
    |> String.split("\n")
  end

  def parse_instructions(instructions, grid) do
    instructions
    |> Enum.map(fn i -> parse_instruction(i) end)
    |> apply_instructions(grid)
  end

  def parse_instruction(instruction) do
    ~r/(.+) (\d+,\d+) through (\d+,\d+)/
    |> Regex.run(instruction)
    |> transform_tokens
  end

  defp transform_tokens([_, action_text, corner1_text, corner2_text]) do
    {
      case action_text do
        "turn on" -> :turn_on
        "turn off" -> :turn_off
        "toggle" -> :toggle
      end,
      corner1_text |> obtain_coords_for_corner,
      corner2_text |> obtain_coords_for_corner
    }
  end

  defp obtain_coords_for_corner(corner) do
    corner
    |> String.split(",")
    |> Enum.map(&(Integer.parse(&1)))
    |> Enum.map(fn {e, _} -> e end)
  end

  def generate_grid_with_size(n) do
    for i <- 0..n-1, j <- 0..n-1, do: {{i, j}, 0}, into: %{}
  end

  def apply_instruction({action, [x1, y1], [x2, y2]}, grid) do
    lit_actions = for i <- x1..x2, j <- y1..y2, do: {{i,j}, apply_action(action, Map.get(grid, {i,j}))}, into: %{}
    Map.merge(grid, lit_actions)
  end

  defp apply_action(:turn_on, _), do: 1
  defp apply_action(:turn_off, _), do: 0
  defp apply_action(:toggle, 1), do: 0
  defp apply_action(:toggle, 0), do: 1

  def apply_instructions([], grid), do: grid
  def apply_instructions([instruction | instructions], grid) do
    new_grid = apply_instruction(instruction, grid)
    apply_instructions(instructions, new_grid)
  end

  def count_lits(grid) do
    grid
    |> Enum.map(fn
      {{_, _}, 1} -> 1
      _ -> 0
    end)
    |> Enum.sum
  end

end
