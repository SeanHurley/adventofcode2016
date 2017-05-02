defmodule Day2Test do
  use ExUnit.Case

  test "starts at 5" do
    code = Day2.code_from_instructions(Day2.keypad1, "\n")
    assert code == "5"
  end

  test "allows moves up" do
    code = Day2.code_from_instructions(Day2.keypad1, "U\n")
    assert code == "2"
  end

  test "doesn't allow moving up past top row" do
    code = Day2.code_from_instructions(Day2.keypad1, "UU\n")
    assert code == "2"
  end

  test "allows moves down" do
    code = Day2.code_from_instructions(Day2.keypad1, "D\n")
    assert code == "8"
  end

  test "doesn't allow moving up past bottom row" do
    code = Day2.code_from_instructions(Day2.keypad1, "DD\n")
    assert code == "8"
  end

  test "allows moves right" do
    code = Day2.code_from_instructions(Day2.keypad1, "R\n")
    assert code == "6"
  end

  test "doesn't allow moving up past right column" do
    code = Day2.code_from_instructions(Day2.keypad1, "RR\n")
    assert code == "6"
  end

  test "allows moves left" do
    code = Day2.code_from_instructions(Day2.keypad1, "L\n")
    assert code == "4"
  end

  test "doesn't allow moving up past left column" do
    code = Day2.code_from_instructions(Day2.keypad1, "LL\n")
    assert code == "4"
  end

  test "parses multiple linse" do
    code = Day2.code_from_instructions(Day2.keypad1, "ULL\nRRDDD\nLURDL\nUUUUD\n")
    assert code == "1985"
  end

  test "reads from a file" do
    code = Day2.code_from_file(Day2.keypad1, "test/data/day2.txt")
    assert code == "1985"
  end
end
