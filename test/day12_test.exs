defmodule Day12Test do
  use ExUnit.Case

  test "copies values to registers" do
    registers = Day12.evaluate([
      "cpy 41 a",
    ])

    assert registers == %{
      a: 41,
      b: 0,
      c: 0,
      d: 0,
    }
  end

  test "copies registers to registers" do
    registers = Day12.evaluate([
      "cpy 41 a",
      "cpy a b",
    ])

    assert registers == %{
      a: 41,
      b: 41,
      c: 0,
      d: 0,
    }
  end

  test "increments registers" do
    registers = Day12.evaluate([
      "inc a",
    ])

    assert registers == %{
      a: 1,
      b: 0,
      c: 0,
      d: 0,
    }
  end

  test "decrements registers" do
    registers = Day12.evaluate([
      "dec a",
    ])

    assert registers == %{
      a: -1,
      b: 0,
      c: 0,
      d: 0,
    }
  end

  test "jumps" do
    registers = Day12.evaluate([
      "cpy 41 a",
      "inc a",
      "inc a",
      "dec a",
      "jnz a 2",
      "dec a",
    ])

    assert registers == %{
      a: 42,
      b: 0,
      c: 0,
      d: 0,
    }
  end

  test "executes_from_file" do
    registers = Day12.evaluate_from_file("test/data/day12.txt")

    assert registers == %{
      a: 42,
      b: 0,
      c: 0,
      d: 0,
    }
  end
end
