defmodule Day19 do
  def winner(count) do
    Enum.reduce(1..count, 1, fn(next, current) ->
      next_odd = current + 2
      if next_odd <= next do
        next_odd
      else
        1
      end
    end)
  end

  def winner2(count) do
    Enum.reduce(1..count, 1, fn(next, current) ->
      half = Float.floor(next / 2)
      current = if half <= current do
        current + 2
      else
        current + 1
      end

      if current < next || (current == next && rem(current, 2) == 1) do
        current
      else
        1
      end
    end)
  end
end
