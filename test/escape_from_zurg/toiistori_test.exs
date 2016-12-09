defmodule ToiistoriTest do
  use ExUnit.Case
  import Toiistori

  test "which is the slower and faster" do
    toys = [
      {"Buzz" ,  5},
      {"Woody" , 10},
      {"Rex"   , 20},
      {"Hamm"  , 25}
    ]
    assert {"Hamm",25} == toys |> is_the_slowest
    assert {"Buzz",5} == toys |> is_the_fastest
  end

  test "how much is the time for the combination" do
    assert the_time_for_this_pair({"Buzz",5},{"Woody",10}) == 20
  end

  test "calculate the time" do
    toys = [
      {"Buzz" ,  5},
      {"Woody" , 10},
      {"Rex"   , 20},
      {"Hamm"  , 25}
    ]
    assert 85 == running_the_bridge(0, toys)
    toys = [
      {"Woody" , 10},
      {"Rex"   , 20},
      {"Hamm"  , 25},
      {"Buzz" ,  5}
    ]
    assert 115 == running_the_bridge(0, toys)
  end

end
