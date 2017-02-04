defmodule GitHub.Coordinator do

  def loop(results \\ [], results_expected) do
    receive do
      {:ok, result} ->
        new_results = results ++ [result]
        if Enum.count(new_results) == results_expected do
          send self, :exit
        end
        loop(new_results, results_expected)
      :exit ->
        results
        |> Enum.sort
        |> IO.inspect
      _ ->
        loop(results, results_expected)
    end
  end

end
