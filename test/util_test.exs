defmodule UtilTest do
  use ExUnit.Case

  test "parses lines of a file" do
    lines = Util.parse_file("test/data/util.txt")
    assert lines == [
      "foo",
      "bar",
      "baz",
    ]
  end

  test "parses lines of a file splitting on a separator" do
    lines = Util.parse_file("test/data/util_comma.txt", ", ")
    assert lines == [
      "foo",
      "bar",
      "baz",
    ]
  end
end
