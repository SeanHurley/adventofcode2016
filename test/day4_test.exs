defmodule Day4Test do
  use ExUnit.Case

  test "sums sector ids from valid rooms in a file" do
    count = Day4.sector_from_file("test/data/day4.txt")
    assert count == 1514
  end

  test "calculates sector_id from list of rooms" do
    sector = Day4.sector_from_rooms([
      "aaaaa-bbb-z-y-x-5[abxyz]",
      "a-b-c-d-e-f-g-h-8[abcde]",
      "not-a-real-room-6[oarel]",
      "totally-real-room-200[decoy]",
    ])
    assert sector == 19
  end

  test "checks whether a room is valid" do
    assert Day4.room_valid?("aaaaa-bbb-z-y-x", "abxyz")
    assert !Day4.room_valid?("totally-real-room", "decoy")
    assert !Day4.room_valid?("aaaaa-bbb-cc", "bc")
  end

  test "parses room ids" do
    %{sector: sector, checksum: checksum, name: name} = Day4.parse_room("aaaaa-bbb-z-y-x-123[abxyz]")
    assert sector == 123
    assert checksum == "abxyz"
    assert name == "aaaaa-bbb-z-y-x"
  end

  test "decrypts room names" do
    room = %{name: "qzmt-zixmtkozy-ivhz", sector: 343}
    %{name: decrypted_room, sector: sector} = Day4.decrypt_room(room)
    assert decrypted_room == "very encrypted name"
    assert sector == 343
  end
end
