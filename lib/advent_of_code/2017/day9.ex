defmodule AdventOfCode.Day9 do
  def trace_routes(vertices) do
    vertices
    |> uniq_origins()
    |> Enum.map(&trace_routes(&1, vertices))
  end

  defp uniq_origins(vertices) do
    for({a, b, _} <- vertices, do: [a, b])
    |> Enum.concat()
    |> Enum.uniq()
  end

  defp trace_routes(origin, vertices) do
    next_places = Enum.filter(vertices, fn {a, b, _} -> a == origin || b == origin end)
    trace_routes(origin, next_places, {[], 0})
  end

  defp trace_routes(_origin, [], route), do: route

  defp trace_routes(origin, [{origin, destiny, distance} | t], {places, total_distance}) do
    next_places = Enum.filter(t, fn {a, b, _} -> a == destiny || b == destiny end)
    trace_routes(destiny, next_places, {[origin | places], total_distance + distance})
  end

  defp trace_routes(origin, [{destiny, origin, distance} | t], {places, total_distance}) do
    next_places = Enum.filter(t, fn {a, b, _} -> a == destiny || b == destiny end)
    trace_routes(destiny, next_places, {[origin | places], total_distance + distance})
  end
end
