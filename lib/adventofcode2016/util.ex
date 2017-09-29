defmodule Util do
  def parse_file(filename, separator \\ "\n") do
    {:ok, contents} = File.read(filename)
    String.trim(contents)
    |> String.split(separator)
  end

  def pmap(collection, func) do
    collection
    |> Enum.map(&(Task.async(fn -> func.(&1) end)))
    |> Enum.map(&Task.await/1)
  end
end
