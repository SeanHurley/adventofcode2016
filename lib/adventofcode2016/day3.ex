defmodule Day3 do
  def count_valid_triangles_from_column_file(filename) do
    Util.parse_file(filename)
    |> parse_string
    |> count_valid_triangles_columns
  end

  def count_valid_triangles_from_file(filename) do
    Util.parse_file(filename)
    |> count_valid_triangles_from_string
  end

  defp parse_string(contents) do
    Enum.map(contents, &(String.trim(&1)))
    |> Enum.map(&(String.split(&1, ~r/\s+/)))
    |> Enum.map(&(Enum.map(&1, fn(str) -> String.to_integer(str) end)))
  end

  defp count_valid_triangles_from_string(contents) do
    triangles = parse_string(contents)
    count_valid_triangles(triangles)
  end

  def count_valid_triangles_columns(triangle_columns) do
    first = Enum.map(triangle_columns, &(Enum.at(&1, 0)))
    second = Enum.map(triangle_columns, &(Enum.at(&1, 1)))
    third = Enum.map(triangle_columns, &(Enum.at(&1, 2)))

    total_list = first ++ second ++ third
    triangles = Enum.chunk(total_list, 3)
    count_valid_triangles(triangles)
  end

  def count_valid_triangles(triangles) do
    Enum.count(triangles, &triangle_valid?/1)
  end

  def triangle_valid?(sides) do
    [x, y, z] = Enum.sort(sides)
    x + y > z
  end
end
