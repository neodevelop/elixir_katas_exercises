defmodule AdventOfCode.Year2022.Day2Test do
  use ExUnit.Case

  setup do
    %{
      guide: """
      A Y
      B X
      C Z
      """
    }
  end

  test "get total score for strategy guide", %{guide: guide} do
    assert 15 == AdventOfCode.Year2022.Day2.compute_score(guide)
  end

  test "get total score for the guide figure out the round", %{guide: guide} do
    assert 12 == AdventOfCode.Year2022.Day2.compute_score_2(guide)
  end
end
