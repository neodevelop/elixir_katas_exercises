defmodule ProcessRing do

  def chain(0) do
    # Change for Process.exit
    IO.puts "End of the line"
  end

  def chain(n) do
    pid = spawn(__MODULE__, :chain, [n-1])
    receive do
      msg ->
        :timer.sleep 500
        IO.puts "P#{n}, Msg: #{msg}"
        send pid, msg
    end
  end

  defmodule RingWorker do

    def loop(idx) do
      receive do
        {next_id, link_pid} ->
          IO.puts("#{idx} linked to #{next_id} at process #{inspect(link_pid)}")
          loop idx, {next_id, link_pid}
        _ ->
          IO.inspect "Not recognized at idx"
          loop idx
      end
    end

    def loop(current_id, {_next_id, next_process} = next) do
      receive do
        {msg, 1} ->
          IO.puts "#{msg} at 1"
          loop current_id, next
        {msg, n} when n > 1 ->
          IO.puts "#{msg} at #{n} at #{inspect(self)}"
          send next_process, {msg, n-1}
          loop current_id, next
        _ ->
          IO.inspect "Not recognized at id, tuple"
      end
    end

  end

  defmodule RingCoordinator do
    def start(size) do
      workers = 1..size |> Enum.map(&(spawn(RingWorker, :loop, [&1])))
      for {pid, idx} <- Enum.with_index(workers) do
        next_idx = rem(idx+1, size)
        send pid, {next_idx + 1, Enum.at(workers, next_idx)}
      end
      workers
    end
  end

end
