defmodule Toiistori do
  def escape_from_zurg(_toys) do
  end

  def is_the_slowest(toys) do
    toys
    |> Enum.max_by(fn {_k, v} ->
      v
    end)
  end

  def is_the_fastest(toys) do
    toys
    |> Enum.min_by(fn {_k, v} ->
      v
    end)
  end

  def the_time_for_this_pair({_, _}, {_, time}) do
    time * 2
  end

  def running_the_bridge(time \\ 0, toys, who_is_safe \\ []) do
    [t1 | [t2 | rest]] = toys

    case {t1, t2, rest} do
      {_, _, the_rest} when length(the_rest) >= 1 ->
        time = time + the_time_for_this_pair(t1, t2)
        running_the_bridge(time, toys -- [t1], who_is_safe ++ [t1])

      {_, _, []} ->
        {_, last_time} = is_the_slowest([t1, t2])
        time = time + last_time
        time
    end
  end
end
