defmodule Day21Test do
  use ExUnit.Case

  test "swaps positions" do
    scrambled = Day21.command(
      "swap position 4 with position 0",
      String.graphemes("abcde")
    )
    |> to_string

    assert scrambled == "ebcda"
  end

  test "swaps letters" do
    scrambled = Day21.command(
      "swap letter d with letter b",
      String.graphemes("ebcda")
    )
    |> to_string

    assert scrambled == "edcba"
  end

  test "reverses substrings" do
    scrambled = Day21.command(
      "reverse positions 0 through 4",
      String.graphemes("edcba")
    )
    |> to_string

    assert scrambled == "abcde"
  end

  test "rotates strings left" do
    scrambled = Day21.command(
      "rotate left 2 step",
      String.graphemes("abcde")
    )
    |> to_string

    assert scrambled == "cdeab"
  end

  test "rotates strings right" do
    scrambled = Day21.command(
      "rotate right 2 step",
      String.graphemes("bcdea")
    )
    |> to_string

    assert scrambled == "eabcd"
  end

  test "moves characters" do
    scrambled = Day21.command(
      "move position 1 to position 4",
      String.graphemes("bcdea")
    )
    |> to_string

    assert scrambled == "bdeac"
  end

  test "moves characters backwards" do
    scrambled = Day21.command(
      "move position 3 to position 0",
      String.graphemes("bdeac")
    )
    |> to_string

    assert scrambled == "abdec"
  end

  test "rotates based on positions" do
    scrambled = Day21.command(
      "rotate based on position of letter b",
      String.graphemes("abdec")
    )
    |> to_string

    assert scrambled == "ecabd"
  end

  test "unrotates passwords" do
    string = "abcdefgh"
    String.graphemes(string)
    |> Enum.each(fn(char) ->
      scrambled = Day21.command(
        "rotate based on position of letter #{char}",
        String.graphemes(string)
      )
      |> to_string
      unscrambled = Day21.command(
        "unrotate based on position of letter #{char}",
        String.graphemes(scrambled)
      )
      |> to_string

      assert unscrambled == string
    end)
  end

  test "processes multiple commands" do
    scrambled = Day21.scramble([
      "swap position 4 with position 0",
      "swap letter d with letter b",
      "reverse positions 0 through 4",
      "rotate left 1 step",
      "move position 1 to position 4",
      "move position 3 to position 0",
      "rotate based on position of letter b",
      "rotate based on position of letter d",
    ], "abcde")

    assert scrambled == "decab"
  end

  test "processes commands from a file" do
    scrambled = Day21.scramble_from_file("abcde", "test/data/day21.txt")

    assert scrambled == "decab"
  end
end
