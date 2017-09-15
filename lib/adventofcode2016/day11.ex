defmodule Day11 do
  def main(state) do
    {:ok, history} = Agent.start_link(&Map.new/0)
    steps_to_solve(state, history)
  end

  def steps_to_solve(state, history, current_steps \\ 0) do
    if is_solved?(state) do
      current_steps
    else
      previous_steps = Agent.get(history, &Map.get(&1, state, 999999999))
      if previous_steps < current_steps do
        999999999
      else
        # try combinations
        Agent.update(history, &Map.put(&1, state, current_steps))

        elevator_floor = Enum.find(state, nil, &(Enum.member?(&1, "E")))
        combinations = combinations(elevator_floor)
        Enum.flat_map(combinations, fn(combination) ->
          new_up_state = move_up(state, combination)
          new_down_state = move_down(state, combination)
          up_steps = steps_to_solve(new_up_state, history, current_steps + 1)
          down_steps = steps_to_solve(new_down_state, history, current_steps + 1)
          [up_steps, down_steps]
        end)
        |> Enum.min
      end
    end
  end

  def combinations(floor) do
    floor = Enum.reject(floor, &( &1 == "E" ))
    map_groups = Enum.reduce(floor, %{}, fn(current, items) ->
      [element, type] = String.codepoints(current)
      Map.update(items, element, %{type => [current]}, fn(elems) ->
        Map.update(elems, type, [current], fn(list) ->
          [current | list]
        end)
      end)
    end)

    pairs = Enum.flat_map(map_groups, fn({_, items}) ->
      list = Map.values(items)
      if length(list) == 1 do
        []
      else
        [typea, typeb] = list
        Util.combine_lists(typea, typeb)
      end
    end)

    Enum.map(floor, &([&1])) ++ pairs
    |> Enum.uniq
  end

  defp move_up(state, items_to_move) do
    elevator_floor = Enum.find_index(state, fn(floor) -> Enum.member?(floor, "E") end)

    if elevator_floor == 3 do
      state
    else
      items_to_move = ["E" | items_to_move]
      current_floor = Enum.at(state, elevator_floor)

      state = List.update_at(state, elevator_floor + 1, fn(next_floor) ->
        next_floor ++ items_to_move
      end)
      current_floor = Enum.filter(current_floor, fn(item) ->
        !Enum.member?(items_to_move, item)
      end)
      List.replace_at(state, elevator_floor, current_floor)
    end
  end

  defp move_down(state, items_to_move) do
    elevator_floor = Enum.find_index(state, fn(floor) -> Enum.member?(floor, "E") end)

    if elevator_floor == 0 do
      state
    else
      items_to_move = ["E" | items_to_move]
      current_floor = Enum.at(state, elevator_floor)

      state = List.update_at(state, elevator_floor - 1, fn(next_floor) ->
        next_floor ++ items_to_move
      end)
      current_floor = Enum.filter(current_floor, fn(item) ->
        !Enum.member?(items_to_move, item)
      end)
      List.replace_at(state, elevator_floor, current_floor)
    end
  end

  defp is_solved?([first, second, third, _]) do
    Enum.empty?(first)
    && Enum.empty?(second)
    && Enum.empty?(third)
  end
end
