defmodule AdventOfCode.Day4 do

  def assemble(key, n) do
    s = cond do
      n >= 0 && n < 10 -> '000000' ++ Integer.to_char_list n
      n >= 10 && n < 100 -> '00000' ++ Integer.to_char_list n
      n >= 100 && n < 1000 -> '0000' ++ Integer.to_char_list n
      n >= 1000 && n < 10000 -> '000' ++ Integer.to_char_list n
      n >= 10000 && n < 100000 -> '00' ++ Integer.to_char_list n
      n >= 100000 && n < 1000000 -> '0' ++ Integer.to_char_list n
      n >= 1000000 -> Integer.to_char_list n
    end
    key ++ s
  end

  def mining(secret) do
    1..1000000
    |> Parallel.pmap(fn x -> searchForSecret(secret, x, '999999') end)
  end

  def searchForSecret(_secret, n, '000000') do
    n-1
  end

  def searchForSecret(secret, n, _) do
    l = :crypto.hash(:md5 , assemble(secret,n))
        |> Base.encode16()
        |> String.to_char_list
        #searchForSecret(secret, n+1, Enum.take(l,5))
    { n, l }
  end

end
