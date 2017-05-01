defmodule AdventOfCode2016 do
  def main([day]) do
    result = case day do
      "1" -> Day1.distance_from_file("data/day1.txt")
      "1.2" -> Day1.distance_from_file_duplicate("data/day1.txt")
    end
    IO.puts result
  end
end
