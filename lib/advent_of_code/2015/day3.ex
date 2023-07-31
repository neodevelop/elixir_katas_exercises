defmodule AdventOfCode.Day3 do
  require Integer

  def deliver_gifts(path) do
    path
    |> String.split("", trim: true)
    |> travel([{0, 0}], {0, 0})
    |> Enum.count()
  end

  def deliver_gifts_with_robot(path) do
    path
    |> String.split("", trim: true)
    |> get_to_work
    |> Enum.uniq()
    |> Enum.count()
  end

  defp get_to_work(both_path) do
    # Partir caminos, recorrerlos, scar unicos, sumar
    santa =
      both_path
      |> obtain_path_for_santa
      |> travel([{0, 0}], {0, 0})

    robot =
      both_path
      |> obtain_path_for_robot
      |> travel([{0, 0}], {0, 0})

    santa ++ robot
  end

  def obtain_path_for_santa(path) do
    for {e, i} <- path |> Enum.with_index(), Integer.is_even(i), do: e
  end

  def obtain_path_for_robot(path) do
    for {e, i} <- path |> Enum.with_index(), Integer.is_odd(i), do: e
  end

  defp travel([], houses, _) do
    houses
  end

  defp travel([direction | next_directions], houses, {current_x, current_y}) do
    {move_x, move_y} = prepare_for_move_to(direction)
    new_house = {current_x + move_x, current_y + move_y}
    journey = check_the_list_of_houses(new_house, houses)
    travel(next_directions, journey, {current_x + move_x, current_y + move_y})
  end

  defp prepare_for_move_to(direction) do
    case direction do
      ">" -> {1, 0}
      "<" -> {-1, 0}
      "^" -> {0, 1}
      "v" -> {0, -1}
    end
  end

  defp check_the_list_of_houses(new_house, houses) do
    case Enum.any?(houses, fn h -> h == new_house end) do
      true -> houses
      false -> houses ++ [new_house]
    end
  end
end
