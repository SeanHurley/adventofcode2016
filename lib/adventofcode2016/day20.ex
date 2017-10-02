defmodule Day20 do
  def count_allowed_ips(filters) do
    allowed_ips(filters)
    |> count
  end

  def count_allowed_ips_from_file(file) do
    Util.parse_file(file)
    |> count_allowed_ips
  end

  defp count(ranges) do
    ranges
    |> parse
    |> Enum.map(fn({first, last}) ->
      last - first + 1
    end)
    |> Enum.sum
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
