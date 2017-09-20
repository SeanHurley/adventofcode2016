defmodule Day16Test do
  use ExUnit.Case

  # Needs to truncate
  test "generates enough data" do
    extended = Day16.expand("10000", 20)
    assert extended == "10000011110010000111"
  end

  test "expands a string with a dragon curve" do
    extended = Day16.expand("111100001010")
    assert extended == "1111000010100101011110000"
  end

  test "generates checksums" do
    extended = Day16.checksum("110010110100")
    assert extended == "100"
  end

  test "generates checksums for inital state and required size" do
    checksum = Day16.calculate_checksum("10000", 20)
    assert checksum == "01100"
  end
end
