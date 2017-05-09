defmodule Day2Test do
  use ExUnit.Case

  test "starts with nothgin" do
    code = Day2.code_from_instructions([], Day2.keypad1)
    assert code == ""
  end

  test "allows moves up" do
    code = Day2.code_from_instructions(["U"], Day2.keypad1)
    assert code == "2"
  end

  test "doesn't allow moving up past top row" do
    code = Day2.code_from_instructions(["UU"], Day2.keypad1)
    assert code == "2"
  end

  test "allows moves down" do
    code = Day2.code_from_instructions(["D"], Day2.keypad1)
    assert code == "8"
  end

  test "doesn't allow moving up past bottom row" do
    code = Day2.code_from_instructions(["DD"], Day2.keypad1)
    assert code == "8"
  end

  test "allows moves right" do
    code = Day2.code_from_instructions(["R"], Day2.keypad1)
    assert code == "6"
  end

  test "doesn't allow moving up past right column" do
    code = Day2.code_from_instructions(["RR"], Day2.keypad1)
    assert code == "6"
  end

  test "allows moves left" do
    code = Day2.code_from_instructions(["L"], Day2.keypad1)
    assert code == "4"
  end

  test "doesn't allow moving up past left column" do
    code = Day2.code_from_instructions(["LL"], Day2.keypad1)
    assert code == "4"
  end

  test "parses multiple linse" do
    code = Day2.code_from_instructions(["ULL", "RRDDD", "LURDL", "UUUUD"], Day2.keypad1)
    assert code == "1985"
  end

  test "reads from a file" do
    code = Day2.code_from_file(Day2.keypad1, "test/data/day2.txt")
    assert code == "1985"
  end
end
