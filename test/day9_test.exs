defmodule Day9Test do
  use ExUnit.Case

  test "calculates size without expansions for v1" do
    expanded = Day9.expanded_size("ADVENT", "v1")
    assert expanded == 6
  end

  test "calculates size of simple expansions for v1" do
    expanded = Day9.expanded_size("(3x3)XYZ", "v1")
    assert expanded == 9
  end

  test "calculates size for v1" do
    expanded = Day9.expanded_size("X(8x2)(3x3)ABCY", "v1")
    assert expanded == 18
  end

  test "calculates size with many nested expansions for v1" do
    expanded = Day9.expanded_size("(27x12)(20x12)(13x14)(7x10)(1x12)A", "v1")
    assert expanded == 324
  end

  test "calculates size of many overlapping expansions for v1" do
    expanded = Day9.expanded_size("(25x3)(3x3)ABC(2x3)XY(5x2)PQRSTX(18x9)(3x2)TWO(5x7)SEVEN", "v1")
    assert expanded == 238
  end

  test "calculates size without expansions for v2" do
    expanded = Day9.expanded_size("ADVENT", "v2")
    assert expanded == 6
  end

  test "calculates size of simple expansions for v2" do
    expanded = Day9.expanded_size("(3x3)XYZ", "v2")
    assert expanded == 9
  end

  test "calculates size for v2" do
    expanded = Day9.expanded_size("X(8x2)(3x3)ABCY", "v2")
    assert expanded == 20
  end

  test "calculates size with many nested expansions for v2" do
    expanded = Day9.expanded_size("(27x12)(20x12)(13x14)(7x10)(1x12)A", "v2")
    assert expanded == 241920
  end

  test "calculates size of many overlapping expansions for v2" do
    expanded = Day9.expanded_size("(25x3)(3x3)ABC(2x3)XY(5x2)PQRSTX(18x9)(3x2)TWO(5x7)SEVEN", "v2")
    assert expanded == 445
  end
end
