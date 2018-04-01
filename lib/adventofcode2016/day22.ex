defmodule Day22 do
  def count_viable_pairs_from_file(filename) do
    Util.parse_file(filename)
    |> count_viable_pairs
  end

  def print_file(filename) do
    Util.parse_file(filename)
    |> print
  end

  def print([_, _ | nodes]) do
    parse_nodes(nodes)
    |> print_nodes
  end

  def print_nodes(nodes) do
    {max_x, _, _, _} = Enum.max_by(nodes, &(elem(&1, 0)))
    {_, max_y, _, _} = Enum.max_by(nodes, &(elem(&1, 1)))
    Enum.each(0..max_y, fn(y) ->
      Enum.each(0..max_x, fn(x) ->
        node = Enum.find(nodes, fn({n_x, n_y, _, _}) ->
          n_x == x && n_y == y
        end)
        {_, _, used, avail} = node
        if used > 100 do
          IO.write "   |    "
        else
          IO.write String.pad_leading(Integer.to_string(used), 3, " ")
          IO.write "/"
          IO.write String.pad_trailing(Integer.to_string(avail + used), 3, " ")
          IO.write(" ")
        end
      end)
      IO.puts("")
    end)
  end

  def count_viable_pairs([_, _ | nodes]) do
    parsed_nodes = parse_nodes(nodes)
    Enum.reduce(parsed_nodes, 0, fn({a_x, a_y, a_used, _}, curr) ->
      if a_used == 0 do
        curr
      else
        curr + Enum.reduce(parsed_nodes, 0, fn({b_x, b_y, _, b_avail}, curr) ->
          cond do
            b_x == a_x && b_y == a_y -> curr
            b_avail >= a_used -> curr + 1
            true -> curr
          end
        end)
      end
    end)
  end

  defp parse_size(string) do
    String.slice(string, 0..-2)
    |> String.to_integer
  end

  defp parse_nodes(nodes) do
    Enum.map(nodes, fn(node) ->
      [node, _, used, avail, _] = String.split(node, " ", trim: true)
      [_, x, y] = Regex.run(~r/.*-x(\d+)-y(\d+)/, node)
      {String.to_integer(x), String.to_integer(y), parse_size(used), parse_size(avail)}
    end)
  end
end
