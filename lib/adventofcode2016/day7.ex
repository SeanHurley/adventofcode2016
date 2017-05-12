defmodule Day7 do
  @bracket_regex ~r/\[([a-z]*)\]/
  def bracket_regex, do: @bracket_regex

  def count_supports_ssl_from_file(filename) do
    Util.parse_file(filename)
    |> count_supports_ssl
  end

  def count_supports_tls_from_file(filename) do
    Util.parse_file(filename)
    |> count_supports_tls
  end

  def count_supports_ssl(list) do
    Enum.count(list, &supports_ssl?/1)
  end

  def count_supports_tls(list) do
    Enum.count(list, &supports_tls?/1)
  end

  def supports_ssl?(string) do
    outside_brackets = Regex.split(bracket_regex(), string)
    |> aba_matches

    inside_brackets = Regex.scan(bracket_regex(), string)
    |> Enum.map(fn([_, match]) -> match end)
    |> aba_matches

    Enum.any?(outside_brackets, &(has_inverse?(&1, inside_brackets)))
  end

  defp has_inverse?(outer_match, inner_matches) do
    [ao, bo, co] = String.graphemes(outer_match)
    Enum.map(inner_matches, &String.graphemes/1)
    |> Enum.any?(fn([ai, bi, _ci]) ->
      ao == bi && bo == ai && co == bi
    end)
  end

  def supports_tls?(string) do
    outside_brackets = Regex.split(bracket_regex(), string)
    inside_brackets = Regex.scan(bracket_regex(), string)
    |> Enum.map(fn([_, match]) -> match end)

    Enum.any?(outside_brackets, &abba_valid?/1) && !Enum.any?(inside_brackets, &abba_valid?/1)
  end

  def abba_valid?(string) when is_binary(string) do
    abba_valid?(String.graphemes(string))
  end

  def abba_valid?(list) do
    if length(list) < 4 do
      false
    else
      [a, b, c, d | rest] = list
      a == d && b == c && a != b || abba_valid?([b, c, d | rest])
    end
  end

  def aba_matches(list) do
    matches = Enum.flat_map(list, fn(string) ->
      {match_list, _} = String.graphemes(string)
      |> Enum.map_reduce({nil, nil}, &aba_match/2)
      match_list
    end)

    Enum.filter(matches, &(&1))
  end

  def aba_match(c_char, {a_char, b_char}) do
    next_tuple = {b_char, c_char}
    if a_char == c_char && a_char != b_char do
      {a_char <> b_char <> c_char, next_tuple}
    else
      {nil, next_tuple}
    end
  end
end
