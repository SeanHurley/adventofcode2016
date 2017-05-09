defmodule Util do
  def parse_file(filename, separator \\ "\n") do
    {:ok, contents} = File.read(filename)
    String.trim(contents)
    |> String.split(separator)
  end
end
