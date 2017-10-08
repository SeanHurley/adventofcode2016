defmodule Day21 do
  def unscramble_from_file(word, filename) do
    Util.parse_file(filename)
    |> reverse_commands
    |> Enum.reverse
    |> scramble(word)
  end

  def scramble_from_file(word, filename) do
    Util.parse_file(filename)
    |> scramble(word)
  end

  def reverse_commands(commands) do
    Enum.map(commands, fn(command) ->
      command = String.split(command, " ")
      case command do
        ["swap", "position", x, _, _, y] -> "swap position #{y} with position #{x}"
        ["swap", "letter", x, _, _, y] -> "swap letter #{y} with letter #{x}"
        ["reverse", _, x, _, y] -> "reverse positions #{x} through #{y}"
        ["rotate", "left", x, _] -> "rotate right #{x} step"
        ["rotate", "right", x, _] -> "rotate left #{x} step"
        ["move", _, x, _, _, y] -> "move position #{y} to position #{x}"
        ["rotate", "based", _, _, _, _, x] -> "unrotate based on position of letter #{x}"
      end
    end)
  end

  def scramble(functions, word) do
    Enum.reduce(functions, String.graphemes(word), &command/2)
    |> to_string
  end

  def command(function, word) do
    [command | args] = String.split(function, " ")
    case command do
      "swap" -> swap(word, args)
      "reverse" -> reverse(word, args)
      "rotate" -> rotate(word, args)
      "move" -> move(word, args)
      "unrotate" -> unrotate(word, args)
    end
  end

  def unrotate(word, [_, _, _, _, _, character]) do
    index = Enum.find_index(word, &(&1 == character))
    left_rotate = case index do
      0 -> 1
      1 -> 1
      2 -> 6
      3 -> 2
      4 -> 7
      5 -> 3
      6 -> 0
      7 -> 4
    end
    rotate_left(word, left_rotate)
  end

  def reverse(word, [_, first, _, last]) do
    first = String.to_integer(first)
    last = String.to_integer(last)
    Enum.reverse_slice(word, first, last-first+1)
  end

  def rotate(word, ["left", count, _]) do
    rotate_left(word, String.to_integer(count))
  end

  def rotate(word, ["right", count, _]) do
    rotate_right(word, String.to_integer(count))
  end

  def rotate(word, ["based", _, _, _, _, character]) do
    index = Enum.find_index(word, &(&1 == character))
    index = if index >= 4 do
      index + 2
    else
      index + 1
    end
    rotate_right(word, index)
  end

  def move(word, ["position", index, _, _, target]) do
    index = String.to_integer(index)
    target = String.to_integer(target)
    char = Enum.at(word, index)
    word = List.delete_at(word, index)
    List.insert_at(word, target, char)
  end

  def swap(word, ["position", first, _, _, second]) do
    first = String.to_integer(first)
    second = String.to_integer(second)
    swap_letters(word, first, second)
  end

  def swap(word, ["letter", first, _, _, second]) do
    first = Enum.find_index(word, &(&1 == first))
    second = Enum.find_index(word, &(&1 == second))
    swap_letters(word, first, second)
  end

  defp swap_letters(word, first, second) do
    from = Enum.at(word, first)
    to = Enum.at(word, second)
    word = List.replace_at(word, first, to)
    List.replace_at(word, second, from)
  end

  defp rotate_left(word, count) do
    count = if count >= length(word) do
      rem(count, length(word))
    else
      count
    end

    {first, last} = Enum.split(word, count)
    last ++ first
  end

  defp rotate_right(word, count) do
    length = length(word)
    count = if count >= length do
      length - rem(count, length)
    else
      length - count
    end

    {first, last} = Enum.split(word, count)
    last ++ first
  end
end
