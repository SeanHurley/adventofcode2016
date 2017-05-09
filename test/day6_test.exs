defmodule Day6Test do
  use ExUnit.Case

  test "calculates password from most characters in column" do
    password = Day6.calculate_password([
      "eedadn",
      "drvtee",
      "eandsr",
      "raavrd",
      "atevrs",
      "tsrnev",
      "sdttsa",
      "rasrtv",
      "nssdts",
      "ntnada",
      "svetve",
      "tesnvt",
      "vntsnd",
      "vrdear",
      "dvrsen",
      "enarar",
    ])
    assert password == "easter"
  end

  test "calculates password from file" do
    password = Day6.calculate_password_from_file("test/data/day6.txt")
    assert password == "easter"
  end

  test "calculates password from least characters in column" do
    password = Day6.calculate_password_from_least([
      "eedadn",
      "drvtee",
      "eandsr",
      "raavrd",
      "atevrs",
      "tsrnev",
      "sdttsa",
      "rasrtv",
      "nssdts",
      "ntnada",
      "svetve",
      "tesnvt",
      "vntsnd",
      "vrdear",
      "dvrsen",
      "enarar",
    ])
    assert password == "advent"
  end

  test "calculates password from least count in columns file" do
    password = Day6.calculate_password_from_least_file("test/data/day6.txt")
    assert password == "advent"
  end
end
