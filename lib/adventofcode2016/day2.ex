defmodule Day2 do
  @keypad1 %{
    "1" => %{ "U" => "1", "D" => "4", "L" => "1", "R" => "2"},
    "2" => %{ "U" => "2", "D" => "5", "L" => "1", "R" => "3"},
    "3" => %{ "U" => "3", "D" => "6", "L" => "2", "R" => "3"},
    "4" => %{ "U" => "1", "D" => "7", "L" => "4", "R" => "5"},
    "5" => %{ "U" => "2", "D" => "8", "L" => "4", "R" => "6"},
    "6" => %{ "U" => "3", "D" => "9", "L" => "5", "R" => "6"},
    "7" => %{ "U" => "4", "D" => "7", "L" => "7", "R" => "8"},
    "8" => %{ "U" => "5", "D" => "8", "L" => "7", "R" => "9"},
    "9" => %{ "U" => "6", "D" => "9", "L" => "8", "R" => "9"},
  }
  @keypad2 %{
    "1" => %{ "U" => "1", "D" => "3", "L" => "1", "R" => "1"},
    "2" => %{ "U" => "2", "D" => "6", "L" => "2", "R" => "3"},
    "3" => %{ "U" => "1", "D" => "7", "L" => "2", "R" => "4"},
    "4" => %{ "U" => "4", "D" => "8", "L" => "3", "R" => "4"},
    "5" => %{ "U" => "5", "D" => "5", "L" => "5", "R" => "6"},
    "6" => %{ "U" => "2", "D" => "A", "L" => "5", "R" => "7"},
    "7" => %{ "U" => "3", "D" => "B", "L" => "6", "R" => "8"},
    "8" => %{ "U" => "4", "D" => "C", "L" => "7", "R" => "9"},
    "9" => %{ "U" => "9", "D" => "9", "L" => "8", "R" => "9"},
    "A" => %{ "U" => "6", "D" => "A", "L" => "A", "R" => "B"},
    "B" => %{ "U" => "7", "D" => "D", "L" => "A", "R" => "C"},
    "C" => %{ "U" => "8", "D" => "C", "L" => "B", "R" => "C"},
    "D" => %{ "U" => "B", "D" => "D", "L" => "D", "R" => "D"},
  }
  def keypad1, do: @keypad1
  def keypad2, do: @keypad2

  def code_from_file(keypad, filename) do
    Util.parse_file(filename)
    |> code_from_instructions(keypad)
  end

  def code_from_instructions(instructions, keypad) do
    code = Enum.reduce(instructions, "5", &(handle_input_line(keypad, &1, &2)))
    |> String.slice(1..-1)

    code
  end

  defp handle_input_line(keypad, current_line, acc) do
    next_position = String.graphemes(current_line)
    |> Enum.reduce(String.last(acc), &(handle_move(keypad, &1, &2)))
    acc <> next_position
  end

  defp handle_move(keypad, direction, starting_position) do
    Map.get(keypad, starting_position)
    |> Map.get(direction)
  end
end
