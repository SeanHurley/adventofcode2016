defmodule Day24Test do
  use ExUnit.Case

  test "counts minimum steps" do
    count = Day24.count_steps([
      "###########",
      "#0.1.....2#",
      "#.#######.#",
      "#4.......3#",
      "###########",
    ])
    assert count == 20
  end

  test "counts minimum steps from file" do
    count = Day24.count_steps_from_file("test/data/day24.txt")
    assert count == 20
  end
end
