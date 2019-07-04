defmodule AdventOfCode.Day6 do

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
    Enum.map(0..n-1, fn _ -> Enum.map(0..n-1, fn _ -> 0 end) end)
  end

  def apply_instruction(grid, instruction) do
    grid
  end

  def count_lits(grid) do
    grid |> Enum.flat_map(&(&1)) |> Enum.sum
  end

end
