defmodule Day8Test do
  use ExUnit.Case

  def board_to_list(board) do
    Array.to_list(board)
    |> Enum.map(&Array.to_list/1)
  end

  test "counts pixels from a file" do
    count = Day8.pixels_from_file("test/data/day8.txt")
    assert count == 8
  end

  test "draws rectangles" do
    board = Day8.build_board(5, 5)
    board = Day8.process_command("rect 3x2", board)

    assert board_to_list(board) == [
      [1, 1, 1, 0, 0],
      [1, 1, 1, 0, 0],
      [0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0],
    ]
  end

  test "draws rectangles with correct dimensions" do
    board = Day8.build_board(5, 5)
    board = Day8.process_command("rect 2x3", board)

    assert board_to_list(board) == [
      [1, 1, 0, 0, 0],
      [1, 1, 0, 0, 0],
      [1, 1, 0, 0, 0],
      [0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0],
    ]
  end

  test "rotates rows" do
    board = Day8.build_board(5, 5)
    board = Day8.process_command("rect 3x2", board)
    board = Day8.process_command("rotate row y=1 by 3", board)

    assert board_to_list(board) == [
      [1, 1, 1, 0, 0],
      [1, 0, 0, 1, 1],
      [0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0],
    ]
  end

  test "rotates columns" do
    board = Day8.build_board(5, 5)
    board = Day8.process_command("rect 2x3", board)
    board = Day8.process_command("rotate column x=1 by 3", board)

    assert board_to_list(board) == [
      [1, 1, 0, 0, 0],
      [1, 0, 0, 0, 0],
      [1, 0, 0, 0, 0],
      [0, 1, 0, 0, 0],
      [0, 1, 0, 0, 0],
    ]
  end
end
