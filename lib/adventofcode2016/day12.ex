defmodule Day12 do
  defmodule Program do
    defstruct instruction_counter: 0,
      registers: %{ a: 0, b: 0, c: 0, d: 0},
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
    instruction = Enum.at(program.instructions, program.instruction_counter)
    program = process_instruction(instruction, program)
    execute(program)
  end

  defp process_instruction(instruction, program) do
    [instruction | args] = String.split(instruction, " ")

    case instruction do
      "cpy" -> cpy(args, program)
      "inc" -> inc(args, program)
      "dec" -> dec(args, program)
      "jnz" -> jnz(args, program)
    end
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
    jump_by = if (test_value == 0), do: 1, else: String.to_integer(jump_by)
    updated_program_instructions(program, program.registers, jump_by)
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
