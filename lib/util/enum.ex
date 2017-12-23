defmodule AOC.Util.Enum do
  @moduledoc """
  Utility functions for enums.
  """

  @doc """
  find_divs returns pairs of divisors and dividends that divide
  evenly from a list of integers.

  ## Examples

      iex> AOC.Util.Enum.find_divs [4, 5, 2, 8]
      [{2, 4}, {2, 8}, {4, 8}]

  """
  @spec find_divs([integer()]) :: [{integer(), integer()}]
  def find_divs(num_list) when is_list(num_list) do
    num_list_sort = Enum.sort(num_list)

    # cross multiplies the elements of num_list and only keep 
    # evenly divisble pairs
    for a <- num_list_sort,
        b <- List.delete(num_list_sort, a),
        rem(b, a) == 0,
        do: {a, b}
  end

  @doc """
  shift rotates the elements of an enum by the disired amount.

  ## Examples

      iex> AOC.Util.Enum.shift([4, 5, 2, 8], 2)
      [2, 8, 4, 5]

  """
  @spec shift(Enum.t, integer()) :: list()
  def shift([], _), do: []

  def shift(list, shift_amount)
      when is_integer(shift_amount) and
      shift_amount == 0,
      do: list

  def shift(list, shift_amount)
      when is_integer(shift_amount) and
      shift_amount < 0 do

    size = Enum.count(list)
    shift(list, size + shift_amount)
  end

  def shift(list, shift_amount)
      when is_integer(shift_amount) and
      shift_amount > 0 do

    # if shift_amount is greater than size of list,
    # then subtract the two for proper shift
    size = Enum.count(list)
    sa = if shift_amount < size, do: shift_amount, else: shift_amount - size

    shift_helper([], Enum.reverse(list), sa)
  end

  @spec shift_helper(list(), Enum.t, integer()) :: list()
  defp shift_helper(left, right, 0), do: left ++ Enum.reverse(right)
  defp shift_helper(left, [rhead | rtail], shift_amount) do
    shift_helper([rhead | left], rtail, shift_amount - 1)
  end
end
