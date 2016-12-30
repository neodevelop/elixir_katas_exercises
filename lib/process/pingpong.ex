defmodule PingPong do

  def ping(n) do
    receive do
      {pid, x} ->
        :timer.sleep 1000
        IO.puts("Ping! #{x}")
        send pid, {self, x}
        ping(n)
    end
  end

  def pong(n) do
    receive do
      {pid, 0} ->
        Process.exit pid, :kill
        Process.exit self, :kill
      {pid, x} ->
        :timer.sleep 1000
        IO.puts("Pong! #{x}")
        send pid, {self, x - 1}
        pong(n)
    end
  end

  def start(n) do
    IO.puts __MODULE__
    ping = spawn(__MODULE__, :ping, [n])
    pong = spawn(__MODULE__, :pong, [n])
    send ping, {pong, n}
  end

end
