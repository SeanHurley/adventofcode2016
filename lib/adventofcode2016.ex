defmodule AdventOfCode2016 do
  def main([day]) do
    result = case day do
      "1" -> Day1.distance_from_file("data/day1.txt")
      "1.2" -> Day1.distance_from_file_duplicate("data/day1.txt")
      "2" -> Day2.code_from_file(Day2.keypad1, "data/day2.txt")
      "2.2" -> Day2.code_from_file(Day2.keypad2, "data/day2.txt")
    end
    IO.puts result
  end
end
