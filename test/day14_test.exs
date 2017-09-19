defmodule Day14Test do
  use ExUnit.Case

  test "verifies if a hash matches 'xxx' " do
    character_match = Day14.valid_three_characters("0034e0923cc38887a57bd7b1d4f953df")
    assert character_match == "8"
  end

  test "verifies if a hash in the next 1000 matches" do
    {:ok, cache} = Agent.start_link(fn -> %{} end)
    assert !Day14.next_1000_match?("abc", 18, "8", cache)
    assert Day14.next_1000_match?("abc", 39, "e", cache)
  end

  test "verifies if a hash matches 'xxxxx' " do
    assert Day14.valid_five?("e", "3aeeeee1367614f3061d165a5fe3cac3")
    assert !Day14.valid_five?("e", "3aeee1367614f3061d165a5fe3cac3")
  end

  test "checks if the number is a match" do
    {:ok, cache} = Agent.start_link(fn -> %{} end)
    assert !Day14.valid_hash?("abc", 18, cache)
    assert Day14.valid_hash?("abc", 39, cache)
  end

  test "checks if the number is a match with stretching" do
    {:ok, cache} = Agent.start_link(fn -> %{} end)
    assert !Day14.valid_hash?("abc", 5, cache, 2016)
    assert Day14.valid_hash?("abc", 10, cache, 2016)
  end

  test "finds the last keypad index" do
    assert Day14.last_index("abc") == 22728
  end

  test "finds the last keypad index with stretching" do
    assert Day14.last_index("abc", 2016) == 22551
  end
end
