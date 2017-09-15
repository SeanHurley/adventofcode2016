defmodule Day13Test do
  use ExUnit.Case

  test "calculates if a space is open" do
    assert Day13.open_space?({0, 0}, 10)
  end

  test "calculates if a space is closed" do
    assert !Day13.open_space?({9, 6}, 10)
  end

  test "finds shortest path" do
    assert Day13.shortest_path(7, 4, 10) == 11
  end
end
