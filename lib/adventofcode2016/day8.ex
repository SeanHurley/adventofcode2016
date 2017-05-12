defmodule Day8 do
  def file_to_string(filename) do
    build_board_from_file(filename)
    |> Enum.map(&Enum.join/1)
    |> Enum.join("\n")
    |> String.replace("0", " ")
  end

  def build_board(width, height) do
    List.duplicate(0, width)
    |> Array.from_list
    |> List.duplicate(height)
    |> Array.from_list
  end

  def build_board_from_file(filename) do
    board = build_board(50, 6)
    Util.parse_file(filename)
    |> Enum.reduce(board, &process_command/2)
  end

  def pixels_from_file(filename) do
    build_board_from_file(filename)
    |> Enum.reduce(0, fn(row, current) ->
      current + Enum.sum(row)
    end)
  end

  def process_command(command, board) do
    [function | args] = String.split(command)

    case function do
      "rect" -> rect_command(board, args)
      "rotate" -> rotate_command(board, args)
    end
  end

  defp rect_command(board, [args]) do
    [width, height] = String.split(args, "x")
    |> Enum.map(&String.to_integer/1)

    draw_rect(board, width, height)
  end

  defp draw_rect(board, width, height) do
    coordinates = for x <- 0..height-1 do
      for y <- 0..width-1 do
        {x,y}
      end
    end
    |> List.flatten

    Enum.reduce(coordinates, board, fn({x,y}, board) ->
      row = board[x]
      row = Array.set(row, y, 1)
      Array.set(board, x, row)
    end)
  end

  defp rotate_command(board, [_, params, _, shift_by]) do
    [axis, index] = String.split(params, "=")
    if axis == "x" do
      rotate_column(board, String.to_integer(index), String.to_integer(shift_by))
    else
      rotate_row(board, String.to_integer(index), String.to_integer(shift_by))
    end
  end

  defp rotate_row(board, row_index, shift_right_by) do
    row = board[row_index]
    row_size = Array.size(row)
    shift_left_by = row_size - shift_right_by

    shifted_row = for index <- 0..row_size-1 do
      row[rem(index + shift_left_by, row_size)]
    end
    |> Array.from_list

    Array.set(board, row_index, shifted_row)
  end

  defp rotate_column(board, column_index, shift_down_by) do
    column_size = Array.size(board)
    shift_up_by = column_size - shift_down_by
    for index <- 0..column_size-1 do
      board[rem(index + shift_up_by, column_size)][column_index]
    end
    |> Enum.with_index
    |> Enum.reduce(board, fn({value, index}, board) ->
      row = board[index]
      row = Array.set(row, column_index, value)
      Array.set(board, index, row)
    end)
  end
end
