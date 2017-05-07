defmodule Day5 do
  def password_for_advanced_door(door) do
    password_for_advanced_door(%{}, door, 0)
  end

  def password_for_door(door) do
    password_for_door("", door, 0)
  end

  defp password_for_advanced_door(char_map, door, index) do
    if Kernel.map_size(char_map) == 8 do
      Enum.map(0..7, &(Map.get(char_map, Integer.to_string(&1))))
      |> to_string
    else
      current_characters = character_for_index(door, index)
      case current_characters do
        {password_index, character} when password_index in ["0","1","2","3","4","5","6","7"]
          -> password_for_advanced_door(Map.put_new(char_map, password_index, character), door, index + 1)
        _ -> password_for_advanced_door(char_map, door, index + 1)
      end
    end
  end

  defp password_for_door(<<password::bytes-size(8)>>, _, _) do
    password
  end

  defp password_for_door(current_password, door, index) do
    current_characters = character_for_index(door, index)
    case current_characters do
      nil -> password_for_door(current_password, door, index + 1)
      {x, _} -> password_for_door(current_password <> x, door, index + 1)
    end
  end

  def character_for_index(door, index) do
    key = door <> Integer.to_string(index)
    hash = :crypto.hash(:md5, key) |> Base.encode16
    case hash do
      "00000" <> <<first_character::bytes-size(1)>> <> <<second_characer::bytes-size(1)>> <> _
        -> {String.downcase(first_character), String.downcase(second_characer)}
      _ -> nil
    end
  end
end
