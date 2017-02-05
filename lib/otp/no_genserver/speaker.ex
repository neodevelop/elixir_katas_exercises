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

defmodule Server do
  def start(callback_module) do
    parent = self
    spawn fn ->
      loop(callback_module, parent)
    end
  end

  def loop(callback_module, parent) do
    receive do
      msg -> callback_module.handle_message(message, parent)
    end
    loop(callback_module, parent)
  end
end
