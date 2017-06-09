defmodule Day10 do
  def process_file(filename) do
    Util.parse_file(filename)
    |> process_lines
  end

  def process_lines(lines) do
    Enum.reduce(lines, %{}, fn(line, factory) -> update_factory(factory, line) end)
  end

  def update_factory(factory, instruction) do
    [command | rest] = String.split(instruction)
    factory = case command do
      "value" -> update_bot_value(factory, rest)
      "bot" -> update_bot_transfer(factory, rest)
    end
    flatten(factory)
  end

  defp update_bot_value(factory, args) do
    [value, _, _, _, bot] = args
    add_bot_value(factory, bot, String.to_integer(value))
  end

  defp update_bot_transfer(factory, args) do
    [bot, _, _, _, low_target_type, low_target, _, _, _, high_target_type, high_target] = args
    add_bot_transfer(factory, bot, String.to_atom(low_target_type), low_target, String.to_atom(high_target_type), high_target)
  end

  defp add_bot_transfer(factory, bot, low_type, low_target, high_type, high_target) do
    default = %{values: [], low: [low_type, low_target], high: [high_type, high_target]}
    Map.update(factory, :bots, %{bot => default}, fn(bots) ->
      Map.update(bots, bot, default, fn(bot) ->
        Map.put(bot, :low, [low_type, low_target])
        |> Map.put(:high, [high_type, high_target])
      end)
    end)
  end

  defp add_bot_value(factory, bot, value) do
    default = %{values: [value], low: nil, high: nil}
    Map.update(factory, :bots, %{bot => default}, fn(bots) ->
      Map.update(bots, bot, default, fn(bot) ->
        Map.update(bot, :values, [value], fn(values) ->
          [value | values]
        end)
      end)
    end)
  end

  defp add_output_value(factory, output, value) do
    Map.update(factory, :outputs, %{output => value}, fn(outputs) ->
      Map.put(outputs, output, value)
    end)
  end

  defp flatten(factory) do
    if is_flattened?(factory) do
      factory
    else
      bots = Map.get(factory, :bots, [])
      factory = Enum.reduce(bots, factory, fn({bot_number, bot}, factory) ->
        if can_flatten?(bot) do
          run_bot(factory, bot_number)
        else
          factory
        end
      end)
      flatten(factory)
    end
  end

  def can_flatten?(%{values: values, low: low, high: high}) do
    length(values) == 2 &&
      low != nil &&
      high != nil
  end

  def is_flattened?(factory) do
    bots = Map.get(factory, :bots)
    !Enum.any?(bots, fn({_, bot}) -> can_flatten?(bot) end)
  end

  defp run_bot(factory, bot_number) do
    bot = Map.get(factory, :bots)
    |> Map.get(bot_number)

    %{values: values, low: low_target, high: high_target} = bot
    low = Enum.min(values)
    high = Enum.max(values)

    IO.puts "Bot #{bot_number} checking #{low}, #{high}"

    factory = transfer(factory, low, low_target)
    factory = transfer(factory, high, high_target)
    reset_bot(factory, bot_number)
  end

  defp transfer(factory, value, [:output, target]) do
    add_output_value(factory, target, value)
  end

  defp transfer(factory, value, [:bot, target]) do
    add_bot_value(factory, target, value)
  end

  defp reset_bot(factory, bot_number) do
    Map.update(factory, :bots, %{bot_number => %{values: []}}, fn(bots) ->
      Map.update(bots, bot_number, %{values: []}, fn(bot) ->
        Map.put(bot, :values, [])
      end)
    end)
  end
end
