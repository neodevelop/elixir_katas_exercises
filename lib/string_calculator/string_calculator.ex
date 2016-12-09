defmodule StringCalculator do
  def add(s) when byte_size(s) == 0 , do: 0
    String.to_integer s
  end
end
