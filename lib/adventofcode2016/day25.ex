defmodule Day25 do
  defmodule Program do
    defstruct instruction_counter: 0,
      registers: %{ a: 0, b: 0, c: 0, d: 0},
      out: [],
      instructions: []
  end

  def evaluate_from_file(filename, initial_c \\ 0) do
    Util.parse_file(filename)
    |> evaluate(%{a: 0, b: 0, c: initial_c, d: 0})
  end

  def evaluate(instructions, registers \\ %{a: 0, b: 0, c: 0, d: 0}) do
    program = %Program{instructions: instructions, registers: registers}
    execute(program)
  end

  defp execute(%Program{instructions: instructions, registers: registers, instruction_counter: instruction_counter}) when length(instructions) <= instruction_counter do
    registers
  end

  defp execute(program) do
    1
    |> Stream.iterate(&(&1 + 1))
    |> Stream.map(fn(i) ->
      program = %{program | registers: %{a: i, b: 0, c: 0, d: 0}}
      |> Stream.iterate(fn(program) ->
        instruction = Enum.at(program.instructions, program.instruction_counter)
        process_instruction(instruction, program)
      end)
      |> Enum.take(50000)
      |> List.last

      {i, (Enum.reverse program.out) == expected_output(length(program.out))}
    end)
    |> Enum.find_value(fn({i, correct}) ->
      if correct do
        i
      else
        false
      end
    end)
  end

  defp expected_output(size) do
    0
    |> Stream.iterate(fn(i) ->
      if i == 0 do
        1
      else
        0
      end
    end)
    |> Enum.take(size)
  end

  defp process_instruction(instruction, program) do
    [instruction | args] = String.split(instruction, " ")

    case instruction do
      "cpy" -> cpy(args, program)
      "inc" -> inc(args, program)
      "dec" -> dec(args, program)
      "jnz" -> jnz(args, program)
      "tgl" -> tgl(args, program)
      "out" -> out(args, program)
    end
  end

  defp out(args, program) do
    register = String.to_atom(hd(args))
    value = program.registers[register]
    out = [value | program.out]
    %{program | out: out,instruction_counter: program.instruction_counter + 1}
  end

  defp cpy(args, program) do
    [value, register] = args
    registers = program.registers
    registers = Map.put(registers, String.to_atom(register), register_or_value(registers, value))
    updated_program_instructions(program, registers, 1)
  end

  defp inc(args, program) do
    register = String.to_atom(hd(args))
    registers = Map.update(program.registers, register, 0, &(&1 + 1))
    updated_program_instructions(program, registers, 1)
  end

  defp dec(args, program) do
    register = String.to_atom(hd(args))
    registers = Map.update(program.registers, register, 0, &(&1 - 1))
    updated_program_instructions(program, registers, 1)
  end

  def jnz(args, program) do
    [test_value, jump_by] = args
    test_value = register_or_value(program.registers, test_value)
    jump_by = if (test_value == 0), do: 1, else: register_or_value(program.registers, jump_by)
    updated_program_instructions(program, program.registers, jump_by)
  end

  def tgl(args, program) do
    jump_by = register_or_value(program.registers, hd(args))
    instructions = program.instructions
    instructions = List.update_at(instructions, program.instruction_counter + jump_by, fn(instruction) ->
      [command | args] = String.split(instruction, " ")
      case command do
        "tgl" -> "inc #{Enum.join(args, " ")}"
        "cpy" -> "jnz #{Enum.join(args, " ")}"
        "inc" -> "dec #{Enum.join(args, " ")}"
        "dec" -> "inc #{Enum.join(args, " ")}"
        "jnz" -> "cpy #{Enum.join(args, " ")}"
      end
    end)
    %{program | instruction_counter: program.instruction_counter + 1, instructions: instructions}
  end

  defp updated_program_instructions(program, registers, instruction_increment) do
    %{program | registers: registers, instruction_counter: program.instruction_counter + instruction_increment}
  end

  defp register_or_value(registers, input) do
    cond do
      input in ["a","b","c","d"] -> Map.get(registers, String.to_atom(input))
      true -> String.to_integer(input)
    end
  end
end
