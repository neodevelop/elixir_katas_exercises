defmodule AdventOfCode.Year2019.Day1 do
  def compute(mass) do
    Float.floor(mass / 3, 0) - 2
  end

  def compute_with_extra_fuel(fuel, extra \\ 0)
  def compute_with_extra_fuel(fuel, extra) when fuel < 0, do: extra

  def compute_with_extra_fuel(fuel, extra) do
    fuel = compute(fuel)

    cond do
      fuel < 0 -> compute_with_extra_fuel(fuel, extra)
      true -> compute_with_extra_fuel(fuel, extra + fuel)
    end
  end

  def compute_masses(masses) do
    masses
    |> Enum.map(&compute/1)
    |> Enum.sum()
  end

  def compute_masses_with_extras(masses) do
    masses
    |> Enum.map(&compute_with_extra_fuel/1)
    |> Enum.sum()
  end
end
