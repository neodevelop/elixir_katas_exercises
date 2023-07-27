defmodule Parallel do
  def pmap(collection, fun) do
    collection
    |> Stream.map(&spawn_process(&1, self(), fun))
    |> Stream.map(&await/1)
  end

  defp spawn_process(item, parent, fun) do
    pid =
      spawn_link(fn ->
        send(parent, {self(), fun.(item)})
      end)

    pid
  end

  defp await(pid) do
    receive do
      {^pid, result} -> result
    end
  end
end
