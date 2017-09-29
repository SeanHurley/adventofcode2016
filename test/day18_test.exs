defmodule Day18Test do
  use ExUnit.Case

  test "generates the next row" do
    assert Day18.next_row([false, true, true]) == [true, true, true]
    assert Day18.next_row([true, false, true]) == [false, false, false]
    assert Day18.next_row([true, true, false]) == [true, true, true]
    assert Day18.next_row([true, true, true]) == [true, false, true]
    assert Day18.next_row([false, false, true]) == [false, true, false]
    assert Day18.next_row([false, false, true, true, false]) == [false, true, true, true, true]
  end

  test "counts safe tiles" do
    assert Day18.safe_tiles(".^^.^.^^^^", 9) == 38
  end
end
