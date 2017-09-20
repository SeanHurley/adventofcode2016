defmodule Day15Test do
  use ExUnit.Case

  test "checks from a file" do
    assert Day15.first_valid_time_from_file("test/data/day15.txt") == 5
  end

  test "checks if the capsule can fall through" do
    maze = Day15.build_maze([
      "Disc #1 has 5 positions; at time=0, it is at position 4.",
      "Disc #2 has 2 positions; at time=0, it is at position 1.",
    ])

    assert !Day15.can_fall?(maze, 0)
    assert Day15.can_fall?(maze, 5)
  end

  test "finds the first possible time to drop" do
    time = Day15.first_valid_time([
      "Disc #1 has 5 positions; at time=0, it is at position 4.",
      "Disc #2 has 2 positions; at time=0, it is at position 1.",
    ])

    assert time == 5
  end
end
