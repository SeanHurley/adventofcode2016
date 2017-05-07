defmodule AdventOfCode2016 do
  def main([day]) do
    result = case day do
      "1" -> Day1.distance_from_file("data/day1.txt")
      "1.2" -> Day1.distance_from_file_duplicate("data/day1.txt")
      "2" -> Day2.code_from_file(Day2.keypad1, "data/day2.txt")
      "2.2" -> Day2.code_from_file(Day2.keypad2, "data/day2.txt")
      "3" -> Day3.count_valid_triangles_from_file("data/day3.txt")
      "3.2" -> Day3.count_valid_triangles_from_column_file("data/day3.txt")
      "4" -> Day4.sector_from_file("data/day4.txt")
      "4.2" -> Day4.decrypt_from_file("data/day4.txt")
    end
    IO.inspect result, limit: :infinity
  end
end
