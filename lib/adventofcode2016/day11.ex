defmodule Day11 do
  def process do
    game = %{
      f1: ["em", "eg", "dm", "dg", "sg", "sm", "pg", "pm"],
      f2: ["tg", "rg", "rm", "cg", "cm"],
      f3: ["tm"],
      f4: [],
      e: :f1,
    }

    solve([{game, 0}], MapSet.new)
  end

  defp solve([{game, steps} | rest], history) do
    history = MapSet.put(history, game)

    if is_solved?(game) do
      steps
    else
      combos = combos(game)
      |> Enum.filter(&(!MapSet.member?(history, &1)))
      |> Enum.filter(&valid_state?/1)
      |> Enum.map(&({&1, steps+1}))
      history = Enum.reduce(combos, history, &(MapSet.put(&2, elem(&1, 0))))

      solve(rest ++ combos, history)
    end
  end

  defp valid_state?(game) do
    Enum.all?([:f1, :f2, :f3, :f4], fn(floor) ->
      floor = game[floor]
      chips = Enum.filter(floor, &(String.contains?(&1, "m")))
      generators = Enum.filter(floor, &(String.contains?(&1, "g")))
      if generators == [] do
        true
      else
        Enum.all?(chips, fn(chip) ->
          [type, _] = String.graphemes(chip)
          Enum.any?(generators, &(String.contains?(&1, type)))
        end)
      end
    end)
  end

  defp combos(game) do
    floor = game[:e]
    items = game[floor]
    Enum.flat_map(floor_options(floor), fn(next_floor) ->
      combos = Enum.map(pairs(items), fn(items) ->
        update_game(game, floor, next_floor, items)
      end)
      [combos]
    end)
    |> List.flatten
  end

  defp update_game(game, previous_floor, next_floor, items_to_move) do
    game = Map.update!(game, previous_floor, fn(floor) ->
      Enum.reduce(items_to_move, floor, fn(item_to_remove, floor) ->
        List.delete(floor, item_to_remove)
      end)
    end)
    game = Map.put(game, :e, next_floor)
    Map.update!(game, next_floor, &(Enum.sort(items_to_move ++ &1)))
  end

  defp floor_options(floor) do
    case floor do
      :f1 -> [:f2]
      :f2 -> [:f1, :f3]
      :f3 -> [:f2, :f4]
      :f4 -> [:f3]
    end
  end

  defp is_solved?(game) do
    game[:f1] == [] &&
    game[:f2] == [] &&
    game[:f3] == [] &&
    game[:e] == :f4
  end

  defp pairs(list) do
    pairs = Enum.flat_map(list, fn(item) ->
      Enum.map(List.delete(list, item), &(Enum.sort([&1, item])))
    end)
    |> Enum.uniq
    pairs ++ Enum.map(list, &([&1]))
  end
end
