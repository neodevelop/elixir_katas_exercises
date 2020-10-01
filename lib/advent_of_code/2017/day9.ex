defmodule AdventOfCode.Day9 do
  def trace_routes(vertices) do
    vertices
    |> uniq_origins
    |> trace_routes(vertices)
  end

  defp trace_routes(cities, vertices) do
    vertices
    |> Enum.map(fn v ->
      check_cities(Enum.into(cities, %{}, &{&1, false}), v, vertices, cities: [], distance: 0)
    end)
  end

  defp check_cities(_, v, [], info) do
    IO.inspect(v)
    info
  end

  defp check_cities(
         cities,
         {a, b, d} = v,
         vertices,
         [cities: _travel, distance: _distance] = info
       ) do
    new_info = trace_route(a, d, info)
    new_vertices = (vertices -- [v]) |> Enum.filter(fn {i, j, _} -> a != i end)
    new_cities = Map.replace!(cities, a, true)
    new_cities = Map.replace!(new_cities, b, true)
    new_v = Enum.find(new_vertices, fn {i, j, _} -> b == i || b == j end)
    IO.inspect(new_vertices)
    IO.inspect(new_cities)
    IO.inspect(new_info)
    IO.inspect(new_v)
    IO.puts("**************************")

    case Enum.all?(new_cities, fn {_, b} -> b end) do
      true -> trace_route(b, 0, info)
      false -> check_cities(new_cities, new_v, new_vertices, new_info)
    end
  end

  defp trace_route(city, d, cities: cities, distance: distance) do
    [cities: cities ++ [city], distance: distance + d]
  end

  defp uniq_origins(vertices) do
    for({a, b, _} <- vertices, do: [a, b])
    |> Enum.concat()
    |> Enum.uniq()
  end
end
