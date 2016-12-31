defmodule PingPong do

  @doc """
  Make a million of calls to the same message

  ## Examples:

      iex> p = spawn(PingPong, :ping_no_response, [])
      :ok
      iex> 1..1_000_000 |> Stream.map(fn _ -> send(p, :ping) end) |> Enum.count
      :ok

  """
  def ping_no_response do
    receive do
      :ping ->
        IO.puts "Pong and continue..."
    end
    ping_no_response
  end

  def pong_no_response do
    receive do
      :pong ->
        IO.puts "Ping and continue..."
    end
    pong_no_response
  end

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
