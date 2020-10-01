defmodule AdventOfCode.Day9 do
  def trace_routes(vertices) do
    vertices
    |> Enum.map(&trace_routes(&1, vertices))
  end

  defp trace_routes({a, b, d}, vertices) do
    rest_nodes = Enum.filter(vertices, fn {i, j, _} -> b == i end)
    next_node = Enum.find(vertices, fn {i, j, _} -> b == i || b == j end)
    trace_routes(next_node, rest_nodes, {[a], d})
  end

  defp trace_routes(_, [], route), do: route

  defp trace_routes({a, b, d}, vertices, {places, acc}) do
    rest_nodes = Enum.filter(vertices, fn {i, j, _} -> b == i end)
    next_node = Enum.find(vertices, fn {i, j, _} -> b == i || b == j end)
    trace_routes(next_node, rest_nodes, {places ++ [b], acc + d})
  end
end
