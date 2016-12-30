defmodule Speaker do
  def speak do
    receive do
      {:say, msg} ->
        IO.puts msg
        speak
      _other ->
        speak
    end
  end
end
