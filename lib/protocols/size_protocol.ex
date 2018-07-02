defprotocol Size do
  @doc "Obtain the size"
  def size(data)
end

defimpl Size, for: BitString do
  def size(string), do: byte_size(string)
end

defimpl Size, for: Map do
  def size(map), do: map_size(map)
end

defimpl Size, for: Tuple do
  def size(tuple), do: tuple_size(tuple)
end

defimpl String.Chars, for: Tuple do
  def to_string(tuple) do
    interior =
      tuple
      |> Tuple.to_list()
      |> Enum.map(&Kernel.to_string/1)
      |> Enum.join(", ")

    "(#{interior})"
  end
end

defprotocol Typeable, do: def typeof(self)
defimpl Typeable, for: Atom, do: def typeof(_), do: "Atom"
defimpl Typeable, for: BitString, do: def typeof(_), do: "BitString"
defimpl Typeable, for: Float, do: def typeof(_), do: "Float"
defimpl Typeable, for: Function, do: def typeof(_), do: "Function"
defimpl Typeable, for: Integer, do: def typeof(_), do: "Integer"
defimpl Typeable, for: List, do: def typeof(_), do: "List"
defimpl Typeable, for: Map, do: def typeof(_), do: "Map"
defimpl Typeable, for: PID, do: def typeof(_), do: "PID"
defimpl Typeable, for: Port, do: def typeof(_), do: "Port"
defimpl Typeable, for: Reference, do: def typeof(_), do: "Reference"
defimpl Typeable, for: Tuple, do: def typeof(_), do: "Tuple"
