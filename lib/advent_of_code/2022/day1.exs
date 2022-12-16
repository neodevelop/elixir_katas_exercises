s = """
...
"""

# Part 1
s
|> String.trim()
|> String.split("\n\n")
|> Enum.map(fn l -> String.split(l) |> Enum.map(fn e -> String.to_integer(e) end) end)
|> Enum.map(&Enum.sum/1)
|> Enum.max()

# Part 2
s
|> String.trim()
|> String.split("\n\n")
|> Enum.map(fn l -> String.split(l) |> Enum.map(fn e -> String.to_integer(e) end) end)
|> Enum.map(&Enum.sum/1)
|> Enum.sort(:desc)
|> Enum.take(3)
|> Enum.sum()
