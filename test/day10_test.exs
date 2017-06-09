defmodule Day10Test do
  use ExUnit.Case

  test "updates the state of the factory for transfer commands" do
    factory = %{}

    factory = Day10.update_factory(factory, "bot 1 gives low to bot 2 and high to output 3")

    assert factory == %{
      bots: %{
        "1" => %{
          low: [:bot, "2"],
          high: [:output, "3"],
          values: [],
        }
      }
    }
  end

  test "updates the state of the factory for simple commands" do
    factory = %{}

    factory = Day10.update_factory(factory, "value 3 goes to bot 2")

    assert factory == %{
      bots: %{
        "2" => %{ values: [3] }
      }
    }
  end

  test "updates the state of the factory after flattening" do
    factory = %{
      bots: %{
        "2" => %{
          low: [:bot, "1"],
          high: [:output, "0"],
          values: [4],
        }
      }
    }

    factory = Day10.update_factory(factory, "value 3 goes to bot 2")

    assert factory == %{
      bots: %{
        "1" => %{values: [3]},
        "2" => %{
          low: [:bot, "1"],
          high: [:output, "0"],
          values: [],
        }
      },
      outputs: %{"0" => [4]}
    }
  end

  test "flattens multiple times" do
    factory = %{
      bots: %{
        "1" => %{
          low: [:bot, "2"],
          high: [:bot, "3"],
          values: [1],
        },
        "2" => %{
          low: [:bot, "3"],
          high: [:output, "4"],
          values: [2],
        },
        "3" => %{
          low: [:output, "4"],
          high: [:output, "4"],
          values: [],
        }
      }
    }

    factory = Day10.update_factory(factory, "value 0 goes to bot 1")

    assert factory == %{
      bots: %{
        "1" => %{
          low: [:bot, "2"],
          high: [:bot, "3"],
          values: [],
        },
        "2" => %{
          low: [:bot, "3"],
          high: [:output, "4"],
          values: [],
        },
        "3" => %{
          low: [:output, "4"],
          high: [:output, "4"],
          values: [],
        }
      },
      outputs: %{
        "4" => [1, 0, 2],
      }
    }
  end

  test "checks whether a factory is flattened" do
    factory = %{
      bots: %{
        "2" => %{
          low: [:bot, "1"],
          high: [:output, "0"],
          values: [4],
        }
      }
    }

    assert Day10.is_flattened?(factory)
  end

  test "checks whether a factory is not flattened" do
    factory = %{
      bots: %{
        "2" => %{
          low: [:bot, "1"],
          high: [:output, "0"],
          values: [1, 4],
        }
      }
    }

    assert !Day10.is_flattened?(factory)
  end
end
