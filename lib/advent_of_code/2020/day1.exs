
s = """
1721
979
366
299
675
1456
"""

numbers = s |> String.split() |> Enum.map(&String.to_integer/1)

# Part 1
for i <- numbers, j <- numbers, i + j == 2020, do: {i,j}

# Part 2
for i <- numbers, j <- numbers, k <- numbers, i + j + k == 2020, do: {i, j, k, i*j*k}

# TODO: Improve performance
