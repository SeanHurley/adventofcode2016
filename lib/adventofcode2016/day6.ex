defmodule Day6 do
  def calculate_password_from_file(filename) do
    {:ok, contents} = File.read(filename)
    String.trim(contents)
    |> String.split("\n")
    |> calculate_password
  end

  def calculate_password_from_least_file(filename) do
    {:ok, contents} = File.read(filename)
    String.trim(contents)
    |> String.split("\n")
    |> calculate_password_from_least
  end

  def calculate_password_from_least(codes) do
    Enum.reduce(codes, %{}, &count_characters/2)
    |> password_from_map(&least_count/1)
  end

  def calculate_password(codes) do
    Enum.reduce(codes, %{}, &count_characters/2)
    |> password_from_map(&most_count/1)
  end

  defp password_from_map(character_map, deciding_function) do
    1..Kernel.map_size(character_map)
    |> Enum.map(fn(char_index) ->
      Map.get(character_map, char_index-1)
      |> deciding_function.()
    end)
    |> Enum.join("")
  end

  defp most_count(map) do
    {char, _} = Enum.reduce(map, {nil, 0}, fn(current, max) ->
      {_, count} = current
      {_, max_count} = max

      if max_count < count do
        current
      else
        max
      end
    end)
    char
  end

  defp least_count(map) do
    {char, _} = Enum.reduce(map, {nil, :infinity}, fn(current, max) ->
      {_, count} = current
      {_, fewest_count} = max

      if fewest_count > count do
        current
      else
        max
      end
    end)
    char
  end

  defp count_characters(string, characters) do
    String.graphemes(string)
    |> Enum.with_index
    |> Enum.reduce(characters, fn({character, index}, index_map) ->
      Map.update(index_map, index, %{character => 1}, fn(character_map) ->
        Map.update(character_map, character, 1, &(&1 + 1))
      end)
    end)
  end
end
