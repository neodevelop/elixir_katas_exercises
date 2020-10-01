defmodule AdventOfCode.Day9 do
  def trace_routes(vertices) do
    vertices
    |> add_inverted_paths()
    |> Enum.map(&add_to_routes(&1, vertices))
    |> Enum.map(&sum_distances/1)
    |> min_path()
  end

  def add_inverted_paths(vertices) do
    vertices ++ for {a, b, d} <- vertices, do: {b, a, d}
  end

  def add_to_routes(v, vertices) do
    add_to_routes(v, vertices, [])
  end

  def add_to_routes(nil, _, path), do: path
  def add_to_routes(_, [], path), do: path

  def add_to_routes({a, b, _} = v, vertices, path) do
    new_vertices = (vertices -- [v]) |> Enum.filter(fn {i, j, _} -> a != i && a != j end)
    new_v = Enum.find(new_vertices, fn {i, j, _} -> b == i || b == j end)
    add_to_routes(new_v, new_vertices, path ++ [swap_point(v, new_v)])
  end

  def swap_point(v, nil), do: v

  def swap_point({origin, destination, d}, {_origin, destination, _}) do
    {origin, destination, d}
  end

  def swap_point({origin, destination, d}, {destination, _origin, _}) do
    {origin, destination, d}
  end

  def sum_distances(route) do
    distance = for({_, _, d} <- route, do: d) |> Enum.sum()
    %{route: route, distance: distance}
  end

  def min_path(routes) do
    minimal =
      routes
      |> Enum.min_by(& &1.distance)

    [routes: routes, min: minimal]
  end
end
