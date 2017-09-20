defmodule Day15 do
  def first_valid_time_from_file(filename) do
    Util.parse_file(filename)
    |> first_valid_time
  end

  def first_valid_time(setup) do
    maze = build_maze(setup)

    Stream.iterate(0, &(&1+1))
    |> Enum.find(fn(time) ->
      can_fall?(maze, time)
    end)
  end

  def build_maze(setup) do
    Enum.map(setup, fn(disc) ->
      [[_, positions, start]] = Regex.scan(~r/Disc #\d has ([\d]+) positions; at time=0, it is at position ([\d]+)./, disc)
      {String.to_integer(positions), String.to_integer(start)}
    end)
  end

  def can_fall?(maze, drop_time) do
    Enum.with_index(maze)
    |> Enum.map(fn({{positions, start}, offset}) ->
      current_time = drop_time + offset + 1
      rem(start + current_time, positions) == 0
    end)
    |> Enum.all?(&(&1))
  end
end
