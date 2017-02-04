defmodule ProcessRing do

  def chain(0) do
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

  def loop(ring_size, next_process) do
    receive do
      {n} ->
        IO.puts "Current node #{n}"
        :timer.sleep 1000
        if n == ring_size do
          send self, :exit
        else
          send next_process, { n+1 }
        end
        loop(ring_size, next_process)
      :exit ->
        IO.puts "The ring size and the travel are the same"
      _ ->
        loop(ring_size, next_process)
    end
  end

end
