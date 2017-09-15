defmodule Day11Test do
  use ExUnit.Case

  test "handles the base case" do
    steps = Day11.main([
      [],
      [],
      [],
      ["E", "HM", "HG"],
    ])

    assert steps == 0
  end

  test "handles moving the elevator" do
    steps = Day11.main([
      [],
      [],
      ["E", "HM", "HG"],
      [],
    ])

    assert steps == 1
  end

  test "handles moving the elevator up multiple times" do
    steps = Day11.main([
      ["E", "HM", "HG"],
      [],
      [],
      [],
    ])

    assert steps == 3
  end

  test "handles moving the elevator down to get items" do
    steps = Day11.main([
      ["HG"],
      [],
      ["E", "HM"],
      [],
    ])

    assert steps == 5
  end

  test "only moves 2 items at a time" do
    steps = Day11.main([
      [],
      [],
      ["E", "HM", "HG", "LM", "LG"],
      [],
    ])

    assert steps == 3
  end

  test "finds possible combinations" do
    combos = Day11.combinations(["E", "HM", "HG", "LM", "LG"])
    assert Enum.sort(combos) == Enum.sort([[], ["HM"], ["HG"], ["LM"], ["LG"], ["HG", "HM"], ["LG", "LM"]])
  end

  test "finds possible simple combinations" do
    combos = Day11.combinations(["E", "HM"])
    assert Enum.sort(combos) == Enum.sort([[], ["HM"]])
  end

  test "finds possible duplicate combinations" do
    combos = Day11.combinations(["E", "HM", "HG", "HM", "HG"])
    assert Enum.sort(combos) == Enum.sort([[], ["HM"], ["HG"], ["HG", "HM"]])
  end
end
