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

  def loop(next_pid, ring_size) do
    receive do
      {msg, n} ->
        IO.puts "#{msg} at #{n}"
        send next_pid, {msg, n-1}
    end
  end

  def ring(sides) do
    #pid = spawn(__MODULE__, :ring, [sides])
    receive do
      {n} when n == sides ->
        IO.puts "Iguales"
      {n} ->
        IO.puts "No iguales"
    end
    ring(sides)
  end

  def ring_monitor do
    receive do
      msg ->
        IO.puts "#{msg}"
        ring_monitor
    end
  end

end
