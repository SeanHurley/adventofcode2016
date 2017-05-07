defmodule Day5Test do
  use ExUnit.Case

  test "checks if an index is part of the password" do
    assert Day5.character_for_index("abc", 5278568) == {"f", "9"}
    assert Day5.character_for_index("abc", 5278569) == nil
  end

  @tag timeout: 360000
  test "calculates passwords" do
    password = Day5.password_for_door("abc")
    assert password == "18f47a30"
  end

  @tag timeout: 1060000
  test "calculates advanced passwords" do
    password = Day5.password_for_advanced_door("abc")
    assert password == "05ace8e3"
  end
end
