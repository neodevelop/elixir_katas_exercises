defmodule LousyCalculator do
  @typedoc """
  Just a number followed by a string.
  """
  @type number_with_remark :: {number, String.t}

  @spec add(number, number) :: number_with_remark
  def add(x, y), do: {x + y, "You need a calculator to do that?"}

  @spec multiply(number, number) :: number_with_remark
  def multiply(x, y), do: {x * y, "It is like addition on steroids."}
end

defmodule Parser do
  @callback parse(String.t) :: any
  @callback extensions() :: [String.t]
end

defmodule JSONParser do
  @behaviour Parser

  def parse(str), do: IO.puts "parsing JSON"
  def extensions, do: ["json"]
end

defmodule YAMLParser do
  @behaviour Parser

  def parse(str), do: IO.puts "parsing YML"
  def extensions, do: ["yml"]
end
