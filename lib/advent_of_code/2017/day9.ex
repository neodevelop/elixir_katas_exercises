defmodule AdventOfCode.Day9 do
  def trace_routes(vertices) do
    vertices
    |> uniq_origins()
    |> find_starters_nodes_in(vertices)
  end

  defp uniq_origins(vertices) do
    for({a, b, _} <- vertices, do: [a, b])
    |> Enum.concat()
    |> Enum.uniq()
  end

  defp find_starters_nodes_in(origins, vertices) do
    origins
    |> Enum.find()
  end
end
