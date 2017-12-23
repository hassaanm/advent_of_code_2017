defmodule AOC.Solutions.Day6 do
  @moduledoc """
  Solution for Day 6 puzzle of Advent of Code (http://adventofcode.com/2017/day/6).

  ## Puzzle Usage
  In order to solve the puzzle, the input must be split by whitespace,
  mapped to integers, and then run with the desired function (inf_loop_info):

  Regex.split(~r{\s+}, "0 2 7 0", trim: true)
  |> Enum.map(&String.to_integer/1)
  |> AOC.Solutions.Day6.inf_loop_info()
  """

  @doc """
  distribute_memory takes the memory bank with the most load
  and distributes it to all of the banks starting with the
  right most bank (then continues to wrap).

  ## Examples

      iex> AOC.Solutions.Day6.distribute_memory [0, 2, 7, 0]
      [2, 4, 1, 2]

  """
  @spec distribute_memory([integer()]) :: [integer()]
  def distribute_memory(mem_banks) when is_list(mem_banks) do
    # finds most memory and index
    num_banks = Enum.count(mem_banks)
    most_mem = Enum.max(mem_banks)
    most_mem_index = Enum.find_index(mem_banks, &(&1 == most_mem))

    # resets bank with most memory to 0
    new_mem_banks = List.update_at(mem_banks, most_mem_index, fn _ -> 0 end)

    # finds indices of banks that will get the remainder memory
    leftover_indices = AOC.Util.Enum.shift(0..num_banks-1, most_mem_index + 1)

    # evenly distributes excess memory and leftover memory
    # excess memory is amount of memory that all banks will get
    # i.e. div(memory, num_of_banks)
    # leftover memory is the remaining memory that only some banks will get
    # i.e. rem(memory, num_of_banks)
    for {i, li} <- 0..num_banks-1 |> Enum.zip(leftover_indices),
        do: Enum.at(new_mem_banks, i) + div(most_mem, num_banks) + if li < rem(most_mem, num_banks), do: 1, else: 0
  end

  @doc """
  inf_loop_info solves the following problem:
  A debugger program here is having an issue: it is trying to repair a
  memory reallocation routine, but it keeps getting stuck in an infinite loop.

  In this area, there are sixteen memory banks; each memory bank can hold
  any number of blocks. The goal of the reallocation routine is to balance
  the blocks between the memory banks.

  The reallocation routine operates in cycles. In each cycle, it finds the
  memory bank with the most blocks (ties won by the lowest-numbered memory
  bank) and redistributes those blocks among the banks. To do this, it removes
  all of the blocks from the selected bank, then moves to the next (by index)
  memory bank and inserts one of the blocks. It continues doing this until it
  runs out of blocks; if it reaches the last memory bank, it wraps around to
  the first one.

  The debugger would like to know how many redistributions can be done before
  a blocks-in-banks configuration is produced that has been seen before.

  For example, imagine a scenario with only four memory banks:

  The banks start with 0, 2, 7, and 0 blocks. The third bank has the most blocks,
  so it is chosen for redistribution.
  Starting with the next bank (the fourth bank) and then continuing to the first
  bank, the second bank, and so on, the 7 blocks are spread out over the memory
  banks. The fourth, first, and second banks get two blocks each, and the third
  bank gets one back. The final result looks like this: 2 4 1 2.
  Next, the second bank is chosen because it contains the most blocks (four).
  Because there are four memory banks, each gets one block. The result is: 3 1 2 3.
  Now, there is a tie between the first and fourth memory banks, both of which
  have three blocks. The first bank wins the tie, and its three blocks are
  distributed evenly over the other three banks, leaving it with none: 0 2 3 4.
  The fourth bank is chosen, and its four blocks are distributed such that each
  of the four banks receives one: 1 3 4 1.
  The third bank is chosen, and the same thing happens: 2 4 1 2.
  At this point, we've reached a state we've seen before: 2 4 1 2 was already seen.
  The infinite loop is detected after the fifth block redistribution cycle, and so
  the answer in this example is 5.

  Out of curiosity, the debugger would also like to know the size of the loop:
  starting from a state that has already been seen, how many block redistribution
  cycles must be performed before that same state is seen again?

  In the example above, 2 4 1 2 is seen again after four cycles, and so the answer
  in that example would be 4.

  Combingin them the output is {steps, loop_size}.

  ## Examples

      iex> AOC.Solutions.Day6.inf_loop_info [0, 2, 7, 0]
      {5, 4}

  """
  @spec inf_loop_info([integer()]) :: {integer(), integer()}
  def inf_loop_info(mem_banks) when is_list(mem_banks) do
    inf_loop_info_helper(mem_banks, [Enum.join(mem_banks, "-")], nil, 0)
  end

  @spec inf_loop_info_helper([integer()], [String.t], integer() | nil, integer()) :: {integer(), integer()}
  defp inf_loop_info_helper(_, _, loop_size, step) when is_integer(loop_size), do: {step, loop_size + 1}
  defp inf_loop_info_helper(mem_banks, patterns, nil, step) do
    new_mem_banks = distribute_memory(mem_banks)
    new_pattern = Enum.join(new_mem_banks, "-")

    inf_loop_info_helper(
      new_mem_banks,
      [new_pattern | patterns],
      Enum.find_index(patterns, &(&1 == new_pattern)),
      step + 1
    )
  end
end
