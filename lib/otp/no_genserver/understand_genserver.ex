defmodule Speaker do
  def speak do
    receive do
      {:say, msg} ->
        IO.puts msg
      _other ->
        # throw away the message
    end
    speak
  end

  def handle_message({:say, msg}) do
    IO.puts msg
  end

  def handle_message(_other) do
    false
  end
end

# pid = spawn(Speaker, :speak, [])
# send pid, {:say, "Hello world"}

defmodule ServerWithNoResponse do
  def start(callback_module) do
    spawn fn ->
      loop(callback_module)
    end
  end

  def loop(callback_module) do
    receive do
      msg -> callback_module.handle_message(msg)
    end
    loop(callback_module)
  end
end

## server = ServerWithNoResponse.start(Speaker)
## send server, {:say, "Hwllo world!"}

defmodule PingPongGS do
  def handle_message(:ping, from) do
    send from, :pong
  end
  def handle_message(:pong, from) do
    send from, :ping
  end
end

defmodule ServerWithResponse do
  def start(callback_module) do
    parent = self
    spawn fn ->
      loop(callback_module, parent)
    end
  end

  def loop(callback_module, parent) do
    receive do
      msg -> callback_module.handle_message(msg, parent)
    end
    loop(callback_module, parent)
  end
end

## ping_pong = ServerWithResponse.start(PingPong)
## send ping_pong, :ping
## flush

defmodule BankAccount do
  def handle_message({:deposit, amount}, _from, balance) do
    balance + amount
  end

  def handle_message({:withdraw, amount}, _from, balance) do
    balance - amount
  end

  def handle_message(:balance, from, balance) do
    send from, {:balance, balance}
    balance
  end
end

defmodule ServerWithResponseAndState do
  def start(callback_module, state) do
    parent = self
    spawn fn ->
      loop(callback_module, parent, state)
    end
  end

  def loop(callback_module, parent, state) do
    receive do
      message ->
        state = callback_module.handle_message(message, parent, state)
        loop(callback_module, parent, state)
    end
  end
end

## account = ServerWithResponseAndState.start(BankAccount, 0)
## send account, {:deposit, 50}
## send account, {:withdraw, 25}
## send account, :balance
## flush
## {:balance, 25}

