defmodule AdventOfCodeTest.Day4 do
  use ExUnit.Case
  doctest AdventOfCode

  test "If secret key is is 'abcdef', the first try is with 0" do
    assert AdventOfCode.Day4.assemble('abcdef',0) == 'abcdef000000'
  end

  test "If your secret key is 'abcdef', the mining is 609043" do
    assert AdventOfCode.Day4.mining("abcdef") == 609043
  end

  test "If your secret key is 'pqrstuv', the mining is abcdef" do
    assert AdventOfCode.Day4.mining("abcdef") == 1048970
  end

end
