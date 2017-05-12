defmodule Day9Test do
  use ExUnit.Case

  test "doesn't expand simple phrases" do
    expanded = Day9.expand("ADVENT")
    assert expanded == "ADVENT"
  end

  test "expands simple expansions" do
    expanded = Day9.expand("A(1x5)BC")
    assert expanded == "ABBBBBC"
  end

  test "expands multiple times" do
    expanded = Day9.expand("(3x3)XYZ")
    assert expanded == "XYZXYZXYZ"
  end

  test "handles expansions inside markers" do
    expanded = Day9.expand("(6x1)(1x3)A")
    assert expanded == "(1x3)A"
  end

  test "handles many expansions" do
    expanded = Day9.expand("X(8x2)(3x3)ABCY")
    assert expanded == "X(3x3)ABC(3x3)ABCY"
  end

  test "handles large expansions" do
    expanded = Day9.expand("(7x2)(1x1)A(1x1)")
    assert expanded == "(1x1)A((1x1)A(1x1)"
  end
end
