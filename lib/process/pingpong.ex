defmodule PingPong do

  def ping(n) do
    receive do
      {pid, x} ->
        :timer.sleep 1000
        IO.puts("Ping!")
        send pid, {self, x}
        ping(n)
    end
  end

  def pong(n) do
    receive do
      {pid, x} ->
        :timer.sleep 1000
        IO.puts("Pong!")
        send pid, {self, x}
        pong(n)
    end
  end

  def start() do
    IO.puts __MODULE__
    ping = spawn(__MODULE__, :ping, [10])
    pong = spawn(__MODULE__, :pong, [10])
    send ping, {pong, 10}
  end

end
