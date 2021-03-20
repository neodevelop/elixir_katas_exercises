defmodule AdventOfCode.Day4 do

  def assemble(key, n) do
    s = cond do
      n >= 0 && n < 10 -> '00000' ++ Integer.to_char_list n
      n >= 10 && n < 100 -> '0000' ++ Integer.to_char_list n
      n >= 100 && n < 1000 -> '000' ++ Integer.to_char_list n
      n >= 1000 && n < 10000 -> '00' ++ Integer.to_char_list n
      n >= 10000 && n < 100000 -> '0' ++ Integer.to_char_list n
      true -> Integer.to_char_list n
      # n >= 100000 && n < 1000000 -> Integer.to_char_list n
      # n >= 1000000 -> Integer.to_char_list n
    end
    key ++ s
  end

  def mining(secret) do
    searchForSecret(secret, 0, '999999')
  end

  def searchForSecret(_secret, n, '000000') do
    n-1
  end

  def searchForSecret(secret, n, _) do
    l = makeTheHash(secret, n)
    searchForSecret(secret, n+1, Enum.take(l,5))
  end

  def makeTheHash(secret, n) do
    :crypto.hash(:md5 , assemble(secret,n))
    |> Base.encode16()
    |> String.to_char_list
  end

  def first_part(secret) do
    1..1000000
    |> Stream.map(fn x -> {x, AdventOfCode.Day4.makeTheHash(secret, x)} end)
    |> Stream.filter(fn {_, h} -> Enum.take(h, 5) == '00000' end)
    |> Enum.to_list
  end

  def second_part(secret) do
    1..10000000
    |> Stream.map(fn x -> {x, AdventOfCode.Day4.makeTheHash(secret, x)} end)
    |> Stream.filter(fn {_, h} -> Enum.take(h, 6) == '000000' end)
    |> Enum.to_list
  end

end
