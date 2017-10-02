defmodule Day20Test do
  use ExUnit.Case

  test "counts ips" do
    allowed_ranges = Day20.count_allowed_ips([
      "1-4294967291",
    ])

    assert allowed_ranges == 5
  end

  test "filters out ranges" do
    allowed_ranges = Day20.allowed_ips([
      "1-4294967295",
    ])

    assert allowed_ranges == ["0-0"]
  end

  test "finds multiple ranges" do
    allowed_ranges = Day20.allowed_ips([
      "1-4294967284",
    ])

    assert allowed_ranges == ["0-0", "4294967285-4294967295"]
  end

  test "parses multiple ranges" do
    allowed_ranges = Day20.allowed_ips([
      "1-4294967284",
      "4294967284-4294967294",
    ])

    assert allowed_ranges == ["0-0", "4294967295-4294967295"]
  end

  test "reads from a file" do
    allowed_ranges = Day20.allowed_ips_from_file("test/data/day20.txt")

    assert allowed_ranges == ["0-0", "4294967292-4294967295"]
  end

  test "counts from a file" do
    allowed_ranges = Day20.count_allowed_ips_from_file("test/data/day20.txt")

    assert allowed_ranges == 5
  end
end
