defmodule Day17Test do
  use ExUnit.Case

  test "checks which directions can be moved based on the hash" do
    directions = Day17.possible_directions("hijkl", {1,1})
    assert directions == ["U", "D", "L"]
  end

  test "checks which directions can be moved based on the boundaries" do
    assert Day17.possible_directions("hijkl", {0,0}) == ["D"]
    assert Day17.possible_directions("hijkl", {3,3}) == ["U", "L"]
  end

  test "checks which doors are available" do
    assert Day17.possible_doors({1,1}) == ["U", "D", "L", "R"]
    assert Day17.possible_doors({0,0}) == ["D", "R"]
    assert Day17.possible_doors({3,3}) == ["U", "L"]
  end

  test "finds the shortest path" do
    assert Day17.shortest_path("ihgpwlah", {0,0}) == "DDRRRD"
    assert Day17.shortest_path("kglvqrro", {0,0}) == "DDUDRLRRUDRD"
    assert Day17.shortest_path("ulqzkmiv", {0,0}) == "DRURDRUDDLLDLUURRDULRLDUUDDDRR"
  end

  test "finds the longest path" do
    assert Day17.longest_path("ihgpwlah", {0,0}) == 370
    assert Day17.longest_path("kglvqrro", {0,0}) == 492
    assert Day17.longest_path("ulqzkmiv", {0,0}) == 830
  end
end
