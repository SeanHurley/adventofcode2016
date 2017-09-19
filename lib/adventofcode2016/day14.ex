use Bitwise

defmodule Day14 do
  def last_index(input, stretch \\ 0) do
    {:ok, cache} = Agent.start_link(fn -> %{} end)
    indices = Enum.reduce(0..63, {0, []}, fn(_, {current_index, current_list}) ->
      next_hash_index = next_index(input, current_index, cache, stretch)
      {next_hash_index + 1, [next_hash_index | current_list]}
    end)
    {_, [last | _]} = indices
    last
  end

  def next_index(prefix, current_index, cache, stretch \\ 0) do
    if valid_hash?(prefix, current_index, cache, stretch) do
      current_index
    else
      next_index(prefix, current_index + 1, cache, stretch)
    end
  end

  def valid_three_characters(input) do
    e = Regex.run(~r/((.)\2{2,})/, input)
    case e do
      nil -> nil
      x -> hd(x) |> String.first
    end
  end

  def valid_five?(character, input) do
    {:ok, regex} = Regex.compile("#{String.duplicate(character, 5)}")
    Regex.run(regex, input)
  end

  def next_1000_match?(prefix, number, initial_match, cache, stretch \\ 0) do
    Enum.map(1..1000, &Task.async(fn -> 
      next_num = number + &1
      next_hash =  md5(prefix, next_num, cache, stretch)
      valid_five?(initial_match, next_hash)
    end))
    |> Enum.map(&Task.await(&1))
    |> Enum.any?(&(&1))
  end

  def valid_hash?(prefix, number, cache, stretch \\ 0) do
    hash = md5(prefix, number, cache, stretch)
    char_match = valid_three_characters(hash)
    case char_match do
      nil -> false
      char_match -> next_1000_match?(prefix, number, char_match, cache, stretch)
    end
  end

  defp md5(prefix, index, cache, stretch) do
    cache_get = Agent.get(cache, &Map.get(&1, index))

    input = prefix <> Integer.to_string(index)
    if cache_get do
      cache_get
    else
      hash = Enum.reduce(0..stretch, input, fn(_, current) ->
        :erlang.md5(current) |> Base.encode16(case: :lower)
      end)
      Agent.update(cache, &Map.put(&1, index, hash))
      hash
    end
  end
end
