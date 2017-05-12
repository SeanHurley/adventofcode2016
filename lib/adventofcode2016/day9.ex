defmodule Day9 do
  @paren_split ~r/(\(\d+x\d+\))/
  def paren_split, do: @paren_split

  def expand_v1_file(filename) do
    {:ok, string} = File.read(filename)
    String.trim(string)
    |> expanded_size("v1")
  end

  def expand_v2_file(filename) do
    {:ok, string} = File.read(filename)
    String.trim(string)
    |> expanded_size("v2")
  end

  def expanded_size("", _) do
    0
  end

  def expanded_size(string, version) do
    if String.match?(string, paren_split()) do
      [start, expand, rest] = Regex.split(paren_split(), string, include_captures: true, parts: 2)

      [characters_to_repeat, repititions] = String.slice(expand, 1..-2)
        |> String.split("x")
        |> Enum.map(&String.to_integer/1)

      {string_to_repeat, rest} = String.split_at(rest, characters_to_repeat)
      expansion_size = if version == "v1" do
        repititions * String.length(string_to_repeat)
      else
        repititions * expanded_size(string_to_repeat, version)
      end

      String.length(start) + expansion_size + expanded_size(rest, version)
    else
      String.length(string)
    end
  end
end
