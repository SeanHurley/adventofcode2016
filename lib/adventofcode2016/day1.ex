defmodule Day1 do
  def distance_from_file(filename) do
    {:ok, string} = File.read(filename)
    distance_from_string(String.trim(string))
  end

  def distance_from_file_duplicate(filename) do
    {:ok, string} = File.read(filename)
    distance_from_string_duplicate(String.trim(string))
  end

  def distance_from_string_duplicate(path_string) do
    {moves, _} = calculate_moves(path_string)
    {absolute_moves, _} = Enum.flat_map_reduce moves, {0, 0}, fn ({_, nx, ny}, {cx, cy}) ->
      [_|rest] = for x <- cx..nx,
          y <- cy..ny,
          do: {x, y}
      {rest, {nx, ny}}
    end
    absolute_moves = [{0, 0} | absolute_moves]
    counts = Enum.reduce absolute_moves, %{}, fn(position, acc) ->
      Map.update(acc, position, 1, &(&1 + 1))
    end
    {x, y} = Enum.find absolute_moves, &(Map.get(counts, &1) > 1)
    abs(x) + abs(y)
  end

  def distance_from_string(path_string) do
    {_, { _, final_x, final_y}} = calculate_moves(path_string)
    abs(final_x) + abs(final_y)
  end

  defp calculate_moves(path_string) do
    String.split(path_string, ", ")
    |> Enum.map(&parse_move/1)
    |> Enum.map_reduce({"N", 0, 0}, &update_move/2)
  end

  defp parse_move(string) do
    {direction, distance} = String.split_at(string, 1)
    {direction, String.to_integer(distance)}
  end

  defp update_move({turn, distance}, {current_direction, x, y}) do
    updated = case current_direction do
      "N" -> case turn do
        "R" -> {"E", x + distance, y}
        "L" -> {"W", x - distance, y}
      end
      "E" -> case turn do
        "R" -> {"S", x, y - distance}
        "L" -> {"N", x, y + distance}
      end
      "S" -> case turn do
        "R" -> {"W", x - distance, y}
        "L" -> {"E", x + distance, y}
      end
      "W" -> case turn do
        "R" -> {"N", x, y + distance}
        "L" -> {"S", x, y - distance}
      end
    end
    {updated, updated}
  end
end
