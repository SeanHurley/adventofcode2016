defmodule Day17 do
  @valid_letters ["B", "C", "D", "E", "F"]

  def longest_path(input, start) do
    longest_path_helper(input, start) - String.length(input)
  end

  defp longest_path_helper(current_path, current_position) do
    if current_position == {3,3} do
      String.length(current_path)
    else
      next_moves(current_path, current_position)
      |> Util.pmap(fn({next_path, _, direction}) ->
        longest_path_helper(next_path <> direction, next_position(current_position, direction))
      end)
      |> Enum.max(fn -> 0 end)
    end
  end

  def shortest_path(input, start) do
    shortest_path(next_moves(input, start))
    |> String.replace(input, "")
  end

  defp shortest_path([{current_path, current_position, next_step} | queue]) do
    next_position = next_position(current_position, next_step)
    next_path = current_path <> next_step
    if next_position == {3, 3} do
      next_path
    else
      shortest_path(queue ++ next_moves(next_path, next_position))
    end
  end

  defp next_moves(next_path, next_position) do
    possible_directions(next_path, next_position)
    |> Enum.map(fn(direction) ->
      {next_path, next_position, direction}
    end)
  end

  defp next_position({x, y}, direction) do
    case direction do
      "U" -> {x, y-1}
      "D" -> {x, y+1}
      "L" -> {x - 1, y}
      "R" -> {x + 1, y}
    end
  end

  def possible_directions(current_path, current_position) do
    possible_doors = possible_doors(current_position)
    current_path
    |> :erlang.md5
    |> Base.encode16(case: :upper)
    |> String.graphemes
    |> Enum.take(4)
    |> Enum.map(&(Enum.member?(@valid_letters, &1)))
    |> Enum.zip(["U", "D", "L", "R"])
    |> Enum.filter(&(elem(&1, 0)))
    |> Enum.map(&(elem(&1, 1)))
    |> Enum.filter(&(Enum.member?(possible_doors, &1)))
  end

  def possible_doors({x, y}) do
    [
      {{x, y - 1}, "U"},
      {{x, y + 1}, "D"},
      {{x - 1, y}, "L"},
      {{x + 1, y}, "R"},
    ]
    |> Enum.filter(&valid_position?/1)
    |> Enum.map(&(elem(&1, 1)))
  end

  defp valid_position?({{x, y}, _}) when x < 0 or y < 0 or y > 3 or x > 3, do: false
  defp valid_position?(_), do: true
end
