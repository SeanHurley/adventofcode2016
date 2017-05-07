defmodule Day4 do
  def decrypt_from_file(filename) do
    {:ok, contents} = File.read(filename)
    String.trim(contents)
    |> String.split("\n")
    |> filter_rooms
    |> Enum.map(&decrypt_room/1)
  end

  def sector_from_file(filename) do
    {:ok, contents} = File.read(filename)
    String.trim(contents)
    |> String.split("\n")
    |> sector_from_rooms
  end

  def parse_room(room) do
    [_, name, sector, checksum] = Regex.run(~r/([a-z\-]*)-(\d*)\[([a-z]*)\]/, room)
    %{sector: String.to_integer(sector), checksum: checksum, name: name}
  end

  def filter_rooms(rooms) do
    Enum.map(rooms, &parse_room/1)
    |> Enum.filter(fn(%{name: name, checksum: checksum}) -> room_valid?(name, checksum) end)
  end

  def sector_from_rooms(rooms) do
    filter_rooms(rooms)
    |> Enum.map(fn(%{sector: sector}) -> sector end)
    |> Enum.sum
  end

  def room_valid?(name, checksum) do
    counts = String.replace(name, "-", "")
    |> String.graphemes
    |> Enum.reduce(%{}, fn(letter, acc) ->
      Map.update(acc, letter, 1, &(&1 + 1))
    end)

    calculated_digits = Map.values(counts)
    |> Enum.sort(fn(x, y) -> x > y end)
    |> Enum.take(5)

    check_digits = String.graphemes(checksum)
    |> Enum.map(fn(letter) ->
      Map.get(counts, letter, 0)
    end)

    calculated_digits == check_digits
  end

  def decrypt_room(%{name: name, sector: sector}) do
    decrypted_name = to_charlist(name)
    |> Enum.map(&(shift(&1, sector)))
    |> to_string
    %{name: decrypted_name, sector: sector}
  end

  defp shift(?-, _) do
    ' '
  end

  defp shift(character, shift_by) do
    alpha = ((character - ?a) + shift_by)
    (rem(alpha, 26) + ?a)
  end
end
