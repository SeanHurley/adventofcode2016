defmodule Day18 do
  def safe_tiles(input, count) do
    convert_string(input)
    |> next_rows(count)
    |> Enum.reduce(0, fn(row, current) ->
      current + Enum.count(row, &(!&1))
    end)
  end

  def next_rows(input, count) do
    Enum.reduce(1..count, [input], fn(_, rows) ->
      [previous | _] = rows
      next_row = next_row(previous)
      [next_row | rows]
    end)
    |> Enum.reverse
  end

  def next_row(input) do
    Enum.map(0..length(input)-1, &(next_row_tile(input, &1)))
  end

  def next_row_tile(input, index) do
    previous_left = tile_at(input, index - 1)
    previous_center = tile_at(input, index)
    previous_right = tile_at(input, index + 1)
    tile(previous_left, previous_center, previous_right)
  end

  def tile(left, center, right) do
    case [left, center, right] do
      [true, true, false] -> true
      [false, true, true] -> true
      [true, false, false] -> true
      [false, false, true] -> true
      _ -> false
    end
  end

  def tile_at(_, index) when index < 0, do: false
  def tile_at(input, index) do
    Enum.at(input, index, false)
  end

  defp convert_string(input) do
    String.graphemes(input)
    |> Enum.map(fn(char) ->
      case char do
        "^" -> true
        "." -> false
      end
    end)
  end
end
