defmodule Day20 do
  def count_allowed_ips_from_file(file) do
    ranges = Util.parse_file(file)
    |> parse

    blocked = remove_overlap(ranges)
    |> Enum.reduce(0, fn({first, last}, total_blocked) ->
      total_blocked + (last - first + 1)
    end)

    4294967296 - blocked
  end

  defp remove_overlap(ranges) do
    Enum.reduce(1..150, ranges, fn(_, ranges) ->
      Enum.map(ranges, fn({first, last}) ->
        {firsts, lasts} = Enum.filter(ranges, fn({second_first, second_last}) ->
          first >= second_first && first <= second_last ||
          last >= second_first && last <= second_last
        end)
        |> Enum.unzip
        {Enum.min(firsts), Enum.max(lasts)}
      end)
    |> Enum.uniq
    end)
  end

  def allowed_ips_from_file(filename) do
    Util.parse_file(filename)
    |> allowed_ips
  end

  def allowed_ips(filter) do
    filter
    |> parse
    |> Enum.sort(fn({first, _}, {second, _}) -> first < second end)
    |> reverse_ranges(-1)
    |> to_strings
  end

  defp parse(filter) do
    Enum.map(filter, fn(filter) ->
      [start, finish] = String.split(filter, "-")
      start = String.to_integer(start)
      finish = String.to_integer(finish)
      {start, finish}
    end)
  end

  defp reverse_ranges([], last) when last < 4294967295, do: [{last + 1, 4294967295}]
  defp reverse_ranges([], _), do: []

  defp reverse_ranges(filter, last) do
    [{start, finish} | rest] = filter
    if start > last + 1 && start > 0 do
      [{last + 1, start-1} | reverse_ranges(rest, finish)]
    else
      reverse_ranges(rest, finish)
    end
  end

  defp to_strings(list) do
    Enum.map(list, fn({start, finish}) ->
      "#{start}-#{finish}"
    end)
  end
end
