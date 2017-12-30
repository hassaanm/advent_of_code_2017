defmodule AOC.Solutions.Day8 do
  @moduledoc """
  Solution for Day 8 puzzle of Advent of Code (http://adventofcode.com/2017/day/8).

  ## Puzzle Usage
  In order to solve the first puzzle, split by newline, call update_register,
  and then find the largest value:

  "input..."
  |> String.split("\n", trim: true)
  |> AOC.Solutions.Day8.update_register()
  |> Map.values()
  |> Enum.max()


  In order to solve the second puzzle, split by newline and then call
  update_register on each line individually, while maintaining the max value:

  "input..."
  |> String.split("\n", trim: true)
  |> Enum.reduce({%{}, 0}, fn inst, {reg, total_max} ->
     new_reg = AOC.Solutions.Day8.update_register([inst], reg)
     curr_max = new_reg |> Map.values() |> Enum.max()
     {new_reg, max(total_max, curr_max)}
   end)
  """

  @condition_regex ~r{(?<register>\w+) (?<action>dec|inc) (?<amount>-?\d+) if (?<condition_register>\w+) (?<condition_operator>>=|>|<=|<|==|!=) (?<condition_amount>-?\d+)}

  @doc """
  update_register solves the following problem:
  Each instruction consists of several parts: the register to modify,
  whether to increase or decrease that register's value, the amount
  by which to increase or decrease it, and a condition. If the condition
  fails, skip the instruction without modifying the register. The
  registers all start at 0. The instructions look like this:

  b inc 5 if a > 1
  a inc 1 if b < 5
  c dec -10 if a >= 1
  c inc -20 if c == 10

  These instructions would be processed as follows:

  Because a starts at 0, it is not greater than 1, and so b is not modified.
  a is increased by 1 (to 1) because b is less than 5 (it is 0).
  c is decreased by -10 (to 10) because a is now greater than or equal to 1
  (it is 1).
  c is increased by -20 (to -10) because c is equal to 10.
  After this process, the largest value in any register is 1.

  You might also encounter <= (less than or equal to) or != (not equal to).
  However, the CPU doesn't have the bandwidth to tell you what all the
  registers are named, and leaves that to you to determine.

  ## Examples

      iex> AOC.Solutions.Day8.update_register ["b inc 5 if a > 1", "a inc 1 if b < 5", "c dec -10 if a >= 1", "c inc -20 if c == 10"]
      %{"a" => 1, "b" => 0, "c" => -10}

  """
  @spec update_register([String.t], map()) :: map()
  def update_register(instruction, register_map \\ %{})
  def update_register([], register_map), do: register_map
  def update_register([instruction | remaining], register_map) when is_map(register_map) do
    # get instruction data
    instruction_data = Regex.named_captures(@condition_regex, instruction)
    register = instruction_data["register"]
    action = instruction_data["action"]
    amount = String.to_integer(instruction_data["amount"])
    condition_register = instruction_data["condition_register"]
    condition_operator = instruction_data["condition_operator"]
    condition_amount = String.to_integer(instruction_data["condition_amount"])

    # insert seen registers into the register_map if not seen before
    # then update the register_map with the instruction
    updated_register =
      register_map
      |> Map.put_new(register, 0)
      |> Map.put_new(condition_register, 0)
      |> update_register_helper(register, action, amount, condition_register, condition_operator, condition_amount)

    # make recursive call with updated values
    update_register(remaining, updated_register)
  end

  @spec update_register_helper(map(), String.t, String.t, integer(), String.t, String.t, integer()) :: map()
  # user pattern matching to help with instruction
  defp update_register_helper(register_map, reg, "dec", amnt, cond_reg, ">=", cond_amnt),
    do: if Map.get(register_map, cond_reg) >= cond_amnt, do: Map.update(register_map, reg, 0, &(&1 - amnt)), else: register_map
  defp update_register_helper(register_map, reg, "dec", amnt, cond_reg, ">", cond_amnt),
    do: if Map.get(register_map, cond_reg) > cond_amnt, do: Map.update(register_map, reg, 0, &(&1 - amnt)), else: register_map
  defp update_register_helper(register_map, reg, "dec", amnt, cond_reg, "<=", cond_amnt),
    do: if Map.get(register_map, cond_reg) <= cond_amnt, do: Map.update(register_map, reg, 0, &(&1 - amnt)), else: register_map
  defp update_register_helper(register_map, reg, "dec", amnt, cond_reg, "<", cond_amnt),
    do: if Map.get(register_map, cond_reg) < cond_amnt, do: Map.update(register_map, reg, 0, &(&1 - amnt)), else: register_map
  defp update_register_helper(register_map, reg, "dec", amnt, cond_reg, "==", cond_amnt),
    do: if Map.get(register_map, cond_reg) == cond_amnt, do: Map.update(register_map, reg, 0, &(&1 - amnt)), else: register_map
  defp update_register_helper(register_map, reg, "dec", amnt, cond_reg, "!=", cond_amnt),
    do: if Map.get(register_map, cond_reg) != cond_amnt, do: Map.update(register_map, reg, 0, &(&1 - amnt)), else: register_map
  defp update_register_helper(register_map, reg, "inc", amnt, cond_reg, ">=", cond_amnt),
    do: if Map.get(register_map, cond_reg) >= cond_amnt, do: Map.update(register_map, reg, 0, &(&1 + amnt)), else: register_map
  defp update_register_helper(register_map, reg, "inc", amnt, cond_reg, ">", cond_amnt),
    do: if Map.get(register_map, cond_reg) > cond_amnt, do: Map.update(register_map, reg, 0, &(&1 + amnt)), else: register_map
  defp update_register_helper(register_map, reg, "inc", amnt, cond_reg, "<=", cond_amnt),
    do: if Map.get(register_map, cond_reg) <= cond_amnt, do: Map.update(register_map, reg, 0, &(&1 + amnt)), else: register_map
  defp update_register_helper(register_map, reg, "inc", amnt, cond_reg, "<", cond_amnt),
    do: if Map.get(register_map, cond_reg) < cond_amnt, do: Map.update(register_map, reg, 0, &(&1 + amnt)), else: register_map
  defp update_register_helper(register_map, reg, "inc", amnt, cond_reg, "==", cond_amnt),
    do: if Map.get(register_map, cond_reg) == cond_amnt, do: Map.update(register_map, reg, 0, &(&1 + amnt)), else: register_map
  defp update_register_helper(register_map, reg, "inc", amnt, cond_reg, "!=", cond_amnt),
    do: if Map.get(register_map, cond_reg) != cond_amnt, do: Map.update(register_map, reg, 0, &(&1 + amnt)), else: register_map
end
