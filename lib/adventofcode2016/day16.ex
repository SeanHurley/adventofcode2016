defmodule Day16 do
  def calculate_checksum(initial, minimum) do
    expand(initial, minimum)
    |> checksum
  end

  def expand(initial, minimum) do
    if String.length(initial) >= minimum do
      String.slice(initial, 0, minimum)
    else
      expand(expand(initial), minimum)
    end
  end

  def expand(input) do
    next_string = String.graphemes(input)
    |> Enum.map(fn(char) ->
      case char do
        "1" -> "0"
        "0" -> "1"
      end
    end)
    |> Enum.reverse
    |> to_string
    input <> "0" <> next_string
  end

  def checksum(input) do
    check = partial_checksum(input)
    if rem(String.length(check), 2) == 1 do
      check
    else
      checksum(check)
    end
  end

  def partial_checksum(input) do
    String.graphemes(input)
    |> Enum.chunk_every(2)
    |> Enum.map(fn([a, b]) ->
      if a == b do
        "1"
      else
        "0"
      end
    end)
    |> to_string
  end
end
