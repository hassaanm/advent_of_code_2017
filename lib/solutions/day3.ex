defmodule AOC.Solutions.Day3 do
  @moduledoc """
  Solution for Day 3 puzzle of Advent of Code (http://adventofcode.com/2017/day/3).
  """

  @doc """
  spiral_man_dist solves the following problem:
  You come across an experimental new kind of memory stored on an
  infinite two-dimensional grid.

  Each square on the grid is allocated in a spiral pattern starting
  at a location marked 1 and then counting up while spiraling outward.
  For example, the first few squares are allocated like this:

  17  16  15  14  13
  18   5   4   3  12
  19   6   1   2  11
  20   7   8   9  10
  21  22  23---> ...

  While this is very space-efficient (no squares are skipped),
  requested data must be carried back to square 1 (the location of the
  only access port for this memory system) by programs that can only
  move up, down, left, or right. They always take the shortest path:
  the Manhattan Distance between the location of the data and square 1.

  ## Examples

      iex> AOC.Solutions.Day3.spiral_man_dist 1
      0

      iex> AOC.Solutions.Day3.spiral_man_dist 12
      3

      iex> AOC.Solutions.Day3.spiral_man_dist 23
      2

      iex> AOC.Solutions.Day3.spiral_man_dist 1024
      31

  """
  @spec spiral_man_dist(integer()) :: integer()
  def spiral_man_dist(1), do: 0
  def spiral_man_dist(num) when is_integer(num) do
    # find the lower and upper square root bounds
    low_bound = num |> :math.sqrt() |> Float.floor() |> round()
    up_bound = low_bound + 2

    # find the square root levels for num
    # it is guaranteed to be odd
    up_lvl =
      low_bound..up_bound
      |> Enum.filter(&(rem(&1, 2) == 1))
      |> Enum.find(&(&1 * &1 >= num))
    low_lvl = up_lvl - 2

    # find the values in the center column
    # and center row for the given level
    low_val = low_lvl * low_lvl
    up_val = up_lvl * up_lvl
    shift_diff = (up_val - low_val) |> div(4)
    center_vals = for n <- 0..3, do: low_val + div(shift_diff, 2) + shift_diff * n

    # minimum steps will be half of (level - 1)
    # i.e. a number in the center column or center row
    min_steps = div(up_lvl - 1, 2)

    # shift steps will be the smallest distance
    # from any of the center values
    shift_steps =
      center_vals
      |> Enum.map(&(abs(&1 - num)))
      |> Enum.sort()
      |> List.first()

    # total steps is the sum of min_steps and shift_steps
    min_steps + shift_steps
  end

  @doc """
  next_spiral_num solves the following problem:
  As a stress test on the system, the programs here clear the grid
  and then store the value 1 in square 1. Then, in the same allocation
  order as shown above, they store the sum of the values in all adjacent
  squares, including diagonals.

  So, the first few squares' values are chosen as follows:

  Square 1 starts with the value 1.
  Square 2 has only one adjacent filled square (with value 1), so it also stores 1.
  Square 3 has both of the above squares as neighbors and stores the sum of their values, 2.
  Square 4 has all three of the aforementioned squares as neighbors and stores the sum of their values, 4.
  Square 5 only has the first and fourth squares as neighbors, so it gets the value 5.
  Once a square is written, its value does not change. Therefore, the first few squares would receive the following values:

  147  142  133  122   59
  304    5    4    2   57
  330   10    1    1   54
  351   11   23   25   26
  362  747  806--->   ...

  ## Examples

      iex> AOC.Solutions.Day3.next_spiral_num 7
      10

      iex> AOC.Solutions.Day3.next_spiral_num 24
      25

      iex> AOC.Solutions.Day3.next_spiral_num 55
      57

  """
  @spec next_spiral_num(integer()) :: integer()
  def next_spiral_num(num) when is_integer(num) do
    next_spiral_num_helper(
      %{{0, 0} => 1},
      {1, 1},
      {[], [{0, -1}, {-1, 0}, {0, 1}, {1, 0}]},
      0,
      2,
      num,
      1
    )
  end

  @spec next_spiral_num_helper(map(), {integer(), integer()}, {list(), list()}, integer(), integer(), integer(), integer()) :: integer()
  # if a number larger than min_num is found, return it
  defp next_spiral_num_helper(_, _, _, _, _, min_num, curr_num) when min_num < curr_num,
    do: curr_num # if a number larger than min_num is found, return it

  # if all directions have been iterated, then reset values and move to next level
  defp next_spiral_num_helper(mat, {x, y}, {dirs, []}, _cs, max_step, min_num, curr_num),
    do: next_spiral_num_helper(mat, {x + 1, y + 1}, {[], Enum.reverse(dirs)}, 0, max_step + 2, min_num, curr_num)

  # if max steps in a direction have been completed, then reset values and move to next direction
  defp next_spiral_num_helper(mat, loc, {dirs, [curr_dir | rem_dirs]}, max_step, max_step, min_num, curr_num),
    do: next_spiral_num_helper(mat, loc, {[curr_dir | dirs], rem_dirs}, 0, max_step, min_num, curr_num)

  defp next_spiral_num_helper(mat, {x, y}, dirs = {_d, [{x_delta, y_delta} | _nd]}, curr_step, max_step, min_num, _cm) do
    # find the next location and value
    next_loc = {x + x_delta, y + y_delta}
    next_num = AOC.Util.Map.sum_adj_mat(mat, next_loc)

    # make recursive call with updated matrix and additional step
    next_spiral_num_helper(
      Map.put(mat, next_loc, next_num),
      next_loc,
      dirs,
      curr_step + 1,
      max_step,
      min_num,
      next_num
    )
  end
end
