defmodule AOC.Solutions.Day5 do
  @moduledoc """
  Solution for Day 5 puzzle of Advent of Code (http://adventofcode.com/2017/day/5).

  ## Puzzle Usage
  In order to solve the puzzle, the input must be split by new line,
  mapped to integers, and then run with the desired function (jump_steps):

  "0\n3\n0\n1\n-3"
  |> String.split("\n", trim: true)
  |> Enum.map(&String.to_integer/1)
  |> AOC.Solutions.Day5.jump_steps()
  """

  @doc """
  jump_steps solves the following problem:
  An urgent interrupt arrives from the CPU: it's trapped in a maze of
  jump instructions, and it would like assistance from any programs
  with spare cycles to help find the exit.

  The message includes a list of the offsets for each jump. Jumps are
  relative: -1 moves to the previous instruction, and 2 skips the next
  one. Start at the first instruction in the list. The goal is to follow
  the jumps until one leads outside the list.

  In addition, these instructions are a little strange; after each jump,
  the offset of that instruction increases by 1. So, if you come across
  an offset of 3, you would move three instructions forward, but change
  it to a 4 for the next time it is encountered.

  For example, consider the following list of jump offsets:

  0
  3
  0
  1
  -3
  Positive jumps ("forward") move downward; negative jumps move upward.
  For legibility in this example, these offset values will be written
  all on one line, with the current instruction marked in parentheses.
  The following steps would be taken before an exit is found:

  (0) 3  0  1  -3  - before we have taken any steps.
  (1) 3  0  1  -3  - jump with offset 0 (that is, don't jump at all). Fortunately, the instruction is then incremented to 1.
   2 (3) 0  1  -3  - step forward because of the instruction we just modified. The first instruction is incremented again, now to 2.
   2  4  0  1 (-3) - jump all the way to the end; leave a 4 behind.
   2 (4) 0  1  -2  - go back to where we just were; increment -3 to -2.
   2  5  0  1  -2  - jump 4 steps forward, escaping the maze.

  In this example, the exit is reached in 5 steps.

  ## Examples

      iex> AOC.Solutions.Day5.jump_steps [0, 3, 0, 1, -3]
      5

  """
  @spec jump_steps([integer()]) :: integer()
  def jump_steps(jump_list) when is_list(jump_list) do
    # convert list to a map with the index as keys for fast access
    {jump_map, _} = Enum.reduce(jump_list, {%{}, 0}, fn(elem, {map, index}) -> {Map.put(map, index, elem), index + 1} end)
    jump_steps_helper(jump_map, 0, List.first(jump_list), 0)
  end

  @spec jump_steps_helper(%{required(integer()) => integer()}, integer(), integer() | nil, integer()) :: integer()
  defp jump_steps_helper(_, _, nil, step), do: step
  defp jump_steps_helper(map, index, value, step) do
    new_index = index + Map.get(map, index)
    new_map = Map.put(map, index, value + 1)
    new_value = Map.get(new_map, new_index) # read from new_map to get proper value for 0 jump
    jump_steps_helper(new_map, new_index, new_value, step + 1)
  end

  @doc """
  bi_jump_steps solves the following problem:
  Now, the jumps are even stranger: after each jump, if the offset was three
  or more, instead decrease it by 1. Otherwise, increase it by 1 as before.

  Using this rule with the above example, the process now takes 10 steps,
  and the offset values after finding the exit are left as 2 3 2 3 -1.

  ## Examples

      iex> AOC.Solutions.Day5.bi_jump_steps [0, 3, 0, 1, -3]
      10

  """
  @spec bi_jump_steps([integer()]) :: integer()
  def bi_jump_steps(jump_list) when is_list(jump_list) do
    # convert list to a map with the index as keys for fast access
    {jump_map, _} = Enum.reduce(jump_list, {%{}, 0}, fn(elem, {map, index}) -> {Map.put(map, index, elem), index + 1} end)
    bi_jump_steps_helper(jump_map, 0, List.first(jump_list), 0)
  end

  @spec bi_jump_steps_helper(%{required(integer()) => integer()}, integer(), integer() | nil, integer()) :: integer()
  defp bi_jump_steps_helper(_, _, nil, step), do: step
  defp bi_jump_steps_helper(map, index, value, step) do
    shift = Map.get(map, index)
    new_index = index + shift
    new_map = Map.put(map, index, (if shift > 2, do: value - 1, else: value + 1))
    new_value = Map.get(new_map, new_index) # read from new_map to get proper value for 0 jump
    bi_jump_steps_helper(new_map, new_index, new_value, step + 1)
  end
end
