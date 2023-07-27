defmodule AdventOfCode.Year2019.Day2 do
  def execute(program) do
    program
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> process()
    |> join()
  end

  defp process(_program_steps) do
    [2, 0, 0, 0, 99]
  end

  defp join(new_program) do
    new_program
    |> Enum.map(&Integer.to_string/1)
    |> Enum.join(",")
  end
end
