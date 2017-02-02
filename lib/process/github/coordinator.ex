defmodule GitHub.Coordinator do

  def loop(results \\ [], results_expected) do
    receive do
      {:ok, result} ->
        new_results = [results | result]
        if Enum.count(new_results) == results_expected do
          send self, :exit
        end
        IO.inspect new_results
        IO.inspect results_expected
        loop(new_results, results_expected)
      :exit ->
        IO.puts(results |> Enum.sort |> Enum.join(','))
      _ ->
        loop(results, results_expected)
    end
  end

end
