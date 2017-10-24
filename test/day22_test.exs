defmodule Day22Test do
  use ExUnit.Case

  test "counts avail" do
    count = Day22.count_viable_pairs([
      "root@ebhq-gridcenter# df -h",
      "Filesystem              Size  Used  Avail  Use%",
      "/dev/grid/node-x0-y0     4T   3T    1T   00%", # 3
      "/dev/grid/node-x2-y2     4T   4T    0T   00%", # 1
      "/dev/grid/node-x4-y4     4T   1T    3T   00%", # 4
      "/dev/grid/node-x6-y6     4T   1T    3T   00%", # 4
      "/dev/grid/node-x8-y8     4T   2T    2T   00%", # 3
      "/dev/grid/node-x10-y10   4T   0T    4T   00%", # 0
    ])

    assert count == 15
  end

  test "counts from a file" do
    count = Day22.count_viable_pairs_from_file("test/data/day22.txt")

    assert count == 15
  end

  test "counts total steps to move data" do
    Day22.print([
      "root@ebhq-gridcenter# df -h",
      "Filesystem            Size  Used  Avail  Use%",
      "/dev/grid/node-x0-y0   10T    8T     2T   80%",
      "/dev/grid/node-x0-y1   11T    6T     5T   54%",
      "/dev/grid/node-x0-y2   32T   28T     4T   87%",
      "/dev/grid/node-x1-y0    9T    7T     2T   77%",
      "/dev/grid/node-x1-y1    8T    0T     8T    0%",
      "/dev/grid/node-x1-y2   11T    7T     4T   63%",
      "/dev/grid/node-x2-y0   10T    6T     4T   60%",
      "/dev/grid/node-x2-y1    9T    8T     1T   88%",
      "/dev/grid/node-x2-y2    9T    6T     3T   66%",
    ])
  end

  test "prints files" do
    Day22.print_file("data/day22.txt")
  end
end
