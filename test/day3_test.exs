defmodule Day3Test do
  use ExUnit.Case

  test "counts from a file" do
    total = Day3.count_valid_triangles_from_file("test/data/day3.txt")
    assert total == 2
  end

  test "counts how many triangles are valid" do
    total = Day3.count_valid_triangles([
      [1, 1, 1],
      [1, 1, 10],
      [2, 3, 9],
      [2, 3, 4],
    ])
    assert total == 2
  end

  test "compares all combinations of sides" do
    assert Day3.triangle_valid?([5, 10, 25]) == false
    assert Day3.triangle_valid?([5, 10, 14]) == true
  end

  test "reads columns" do
    total = Day3.count_valid_triangles_columns([
      [1, 1, 9],
      [1, 10, 2],
      [1, 2, 3],
      [1, 3, 4],
    ])
    assert total == 2
  end
end
