defmodule MyProcess.Link do

  def super_operation(n) do
    IO.puts n*n
    raise "oops!"
  end

  def start do
    Process.flag :trap_exit, true
    op = spawn_link(__MODULE__, :super_operation, [10])
    IO.inspect "***************"
    IO.inspect op
    IO.inspect "***************"
    receive do
      msg ->
        IO.puts "Message : #{inspect msg} :'("
    end
  end

end
