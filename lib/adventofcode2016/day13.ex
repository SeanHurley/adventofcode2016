use Bitwise

defmodule Day13 do
  def shortest_path(target_x, target_y, favorite_number) do
    set = MapSet.new
    set = MapSet.put(set, {1,1})
    queue = [{{1,1}, 0}]
    solve({target_x, target_y}, favorite_number, set, queue)
  end

  defp solve(goal, _, _, [{current, current_steps} | _]) when goal == current, do: current_steps

  defp solve(goal, favorite_number, set, [{current, current_steps} | queue]) do
    possible_neighbors = neighbors(current)
    |> Enum.filter(&(open_space?(&1, favorite_number)))
    |> Enum.filter(&(!MapSet.member?(set, &1)))

    set = Enum.reduce(possible_neighbors, set, fn(neighbor, current_set) -> MapSet.put(current_set, neighbor) end)
    queue = queue ++ Enum.map(possible_neighbors, fn(neighbor) -> {neighbor, current_steps + 1} end)

    solve(goal, favorite_number, set, queue)
  end

  def possible_nodes(favorite_number) do
    set = MapSet.new
    set = MapSet.put(set, {1,1})
    queue = [{{1,1}, 0}]
    solve(favorite_number, set, queue)
  end

  defp solve(_, set, [{_, current_steps} | _]) when current_steps == 50, do: MapSet.size(set)

  defp solve(favorite_number, set, [{current, current_steps} | queue]) do
    possible_neighbors = neighbors(current)
    |> Enum.filter(&(open_space?(&1, favorite_number)))
    |> Enum.filter(&(!MapSet.member?(set, &1)))

    set = Enum.reduce(possible_neighbors, set, fn(neighbor, current_set) -> MapSet.put(current_set, neighbor) end)
    queue = queue ++ Enum.map(possible_neighbors, fn(neighbor) -> {neighbor, current_steps + 1} end)

    solve(favorite_number, set, queue)
  end

  defp neighbors({x, y}) do
    [
      {x+1, y},
      {x-1, y},
      {x, y+1},
      {x, y-1},
    ]
  end

  def open_space?({x, y}, _) when x < 0 or y < 0, do: false

  def open_space?({x, y}, favorite_number) do
    number = x*x + 3*x + 2*x*y + y + y*y + favorite_number
    total = Enum.reduce(0..31, 0, fn(shift_by, total) ->
      if ((number >>> shift_by) &&& 1) == 1 do
        total + 1
      else
        total
      end
    end)

    (total &&& 1) == 0
  end
end
