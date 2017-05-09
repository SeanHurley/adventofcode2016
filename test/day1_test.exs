defmodule Day1Test do
  use ExUnit.Case

  test "counts distance from a string" do
    path = ["R2", "L3"]
    distance = Day1.distance_from_string(path)
    assert distance == 5
  end

  test "cancels out opposite directions" do
    path = ["R2", "R2", "R2"]
    distance = Day1.distance_from_string(path)
    assert distance == 2
  end

  test "reads from a file" do
    distance = Day1.distance_from_file("test/data/day1.txt")
    assert distance == 12
  end

  test "finds duplicate positions" do
    path = ["R2", "R1", "R1", "R2"]
    distance = Day1.distance_from_string_duplicate(path)
    assert distance == 1
  end
end
