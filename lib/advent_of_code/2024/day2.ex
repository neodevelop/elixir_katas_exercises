defmodule AdventOfCode.Year2024.Day2 do
  def safe_reports(reports) do
    reports
    |> parse_reports()
    |> Enum.filter(&valid_report?/1)
    |> Enum.count()
  end

  def safe_reports_with_dampener(reports) do
    reports
    |> parse_reports()
    |> classify_reports()
    |> apply_reactor()
    |> count_all()
    |> dbg()
  end

  defp parse_reports(reports) do
    reports
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, " "))
    |> Enum.map(fn l -> Enum.map(l, &String.to_integer/1) end)
    |> Enum.map(&compute_gaps/1)
  end

  defp compute_gaps(report) do
    %{list: report, gaps: compute_gaps_recursive(report, []), ordered: is_sorted?(report)}
  end

  defp compute_gaps_recursive([_n], gaps), do: gaps

  defp compute_gaps_recursive([h | t], gaps) do
    [n | _] = t
    compute_gaps_recursive(t, gaps ++ [abs(n - h)])
  end

  defp classify_reports(reports) do
    reports
    |> Enum.split_with(&valid_report?/1)
    |> then(fn {safe_reports, unsafe_reports} ->
      %{safe: safe_reports, unsafe: unsafe_reports}
    end)
  end

  defp valid_report?(%{gaps: gaps, ordered: ordered}) do
    Enum.all?(gaps, &(&1 > 0 && &1 <= 3)) && ordered
  end

  defp apply_reactor(%{unsafe: unsafe} = reports) do
    dampenered_reports =
      unsafe
      |> Enum.map(&compute_gaps_with_dampener/1)
      |> Enum.filter(&(&1 != nil))

    reports |> Map.put(:dampenered, dampenered_reports)
  end

  defp compute_gaps_with_dampener(%{list: report} = original_report) do
    report
    |> Enum.with_index()
    |> Enum.map(fn {_e, index} ->
      List.delete_at(report, index)
    end)
    |> Enum.map(&compute_gaps/1)
    |> Enum.find(&valid_report?/1)
  end

  defp count_all(%{safe: safe, dampenered: dampenered} = reports),
    do: reports |> Map.put(:safe_count, Enum.count(safe) + Enum.count(dampenered))

  defp is_sorted?(report) do
    report == Enum.sort(report) || report == Enum.sort(report, &>/2)
  end
end
