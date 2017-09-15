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

  test "combines lists" do
    list = Util.combine_lists([1,2], [3,4,5])
    assert list == [
      [1,3],
      [1,4],
      [1,5],
      [2,3],
      [2,4],
      [2,5],
    ]
  end
end
