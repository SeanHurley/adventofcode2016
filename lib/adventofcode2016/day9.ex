defmodule Day9 do
  @paren_split ~r/(\(\d+x\d+\))/
  def paren_split, do: @paren_split

  def expand_file(filename) do
    {:ok, string} = File.read(filename)
    expand(string)
    |> String.trim
    |> IO.inspect
    |> String.length
  end

  def expand(""), do: ""
  def expand(string) do
    if String.match?(string, paren_split()) do
      [start, expand, rest] = Regex.split(paren_split(), string, include_captures: true, parts: 2)

      [characters_to_repeat, repititions] = String.slice(expand, 1..-2)
        |> String.split("x")
        |> Enum.map(&String.to_integer/1)

      {string_to_repeat, rest} = String.split_at(rest, characters_to_repeat)
      expanded = String.duplicate(string_to_repeat, repititions)

      start <> expanded <> expand(rest)
    else
      string
    end
  end
end
