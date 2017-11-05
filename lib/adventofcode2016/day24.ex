defmodule Day24 do
  def count_steps_from_file(filename) do
    Util.parse_file(filename)
    |> count_steps
  end

  def parse_map(input) do
    Enum.map(input, &String.graphemes/1)
  end

  def count_steps(input) do
    map = parse_map(input)
    targets = find_targets(map)
    start = find_start(map)
    available_moves = available_moves(start, map)
    {:ok, history} = Agent.start_link(fn -> MapSet.new end)
    queue = move_combinations([], 0, history, available_moves, targets)
    shortest_path(queue, history, map)
  end

  def shortest_path([], _, _), do: 0
  def shortest_path([step | queue], history, map) do
    {x, y, current_step, current_target, targets} = step
    Agent.update(history, fn(history) -> MapSet.put(history, {x, y, current_target, targets}) end)

    if at_target?(x, y, current_target, map) do
      if targets == [] do
        if current_target == "0" do
          current_step
        else
          available_moves = available_moves({x, y}, map)
          combinations = move_combinations(queue, current_step, history, available_moves, ["0"])
          shortest_path(queue ++ combinations, history, map)
        end
      else
        available_moves = available_moves({x, y}, map)
        combinations = move_combinations(queue, current_step, history, available_moves, targets)
        shortest_path(queue ++ combinations, history, map)
      end
    else
      available_moves = available_moves({x, y}, map)
      combinations = move_combinations(queue, current_step, history, available_moves, targets, current_target)
      shortest_path(queue ++ combinations, history, map)
    end
  end

  defp find_targets(map) do
    Enum.flat_map(map, fn(row) ->
      Enum.reject(row, &(&1 in ["#", ".", "0"]))
    end)
  end

  defp available_moves({x, y}, map) do
    [
      {x+1, y},
      {x-1, y},
      {x, y+1},
      {x, y-1},
    ]
    |> Enum.reject(fn({x, y}) ->
      x < 0
      || y < 0
      || x >= length(hd(map))
      || y >= length(map)
      || Enum.at(Enum.at(map, y), x) == "#"
    end)
  end

  defp find_start(map) do
    Enum.with_index(map)
    |> Enum.find_value(fn({row, index}) ->
      i = Enum.find_index(row, fn(e) ->
        e == "0"
      end)

      if i do
        {i, index}
      else
        nil
      end
    end)
  end

  defp move_combinations(queue, current_steps, history, moves, targets, current_target \\ nil) do
    moves = if current_target do
      Enum.map(moves, fn({x,y}) -> {x, y, current_steps + 1, current_target, targets} end)
    else
      Enum.flat_map(moves, fn({x,y}) ->
        Enum.map(targets, fn(target) ->
          other_targets = Enum.reject(targets, &(&1 == target))
          {x, y, current_steps + 1, target, other_targets}
        end)
      end)
    end
    Enum.reject(moves, fn(move) ->
      {x, y, _, current_target, targets} = move
      move in queue ||
        Agent.get(history, fn(history) -> MapSet.member?(history, {x, y, current_target, targets}) end)
    end)
  end

  defp at_target?(x, y, target, map) do
    Enum.at(Enum.at(map, y), x) == target
  end
end
