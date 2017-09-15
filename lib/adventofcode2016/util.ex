defmodule Util do
  def parse_file(filename, separator \\ "\n") do
    {:ok, contents} = File.read(filename)
    String.trim(contents)
    |> String.split(separator)
  end

  def combine_lists(first, second) do
    Enum.flat_map(first, fn(a) ->
      Enum.map(second, fn(b) ->
        [a, b]
      end)
    end)
  end
end
