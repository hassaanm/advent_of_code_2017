defmodule AOC.Solutions.Day2 do
  @moduledoc """
  Solution for Day 2 puzzle of Advent of Code (http://adventofcode.com/2017/day/2).
  """

  @doc """
  checksum solves the following problem:
  The spreadsheet consists of rows of apparently-random numbers.
  To make sure the recovery process is on the right track, they
  need you to calculate the spreadsheet's checksum. For each row,
  determine the difference between the largest value and the
  smallest value; the checksum is the sum of all of these differences.

  ## Examples

      iex> AOC.Solutions.Day2.checksum "5 1 9 5\\n7 5 3\\n2 4 6 8"
      18

  """
  @spec checksum(String.t) :: integer()
  def checksum(num_str) when is_bitstring(num_str) do
    num_str
    |> String.split("\n", trim: true)                   # split by newline
    |> Enum.map(&AOC.Util.String.num_row_to_num_list/1) # map each row into a list of numbers
    |> Enum.map(&Enum.min_max/1)                        # find the min and max of each row
    |> Enum.map(fn({min, max}) -> max - min end)        # find the difference of min and max of each row
    |> Enum.sum()                                       # sum the differences of each row
  end

  @doc """
  checksum_div solves the following problem:
  It sounds like the goal is to find the only two numbers in each
  row where one evenly divides the other - that is, where the result
  of the division operation is a whole number. They would like you
  to find those numbers on each line, divide them, and add up each
  line's result.

  ## Examples

      iex> AOC.Solutions.Day2.checksum_div "5 9 2 8\\n9 4 7 3\\n3 8 6 5"
      9

  """
  @spec checksum_div(String.t) :: integer()
  def checksum_div(num_str) when is_bitstring(num_str) do
    num_str
    |> String.split("\n", trim: true)                   # split by newline
    |> Enum.map(&AOC.Util.String.num_row_to_num_list/1) # map each row into a list of numbers
    |> Enum.map(&AOC.Util.Enum.find_divs/1)             # find all pairs of evenly divisible numbers for each row
    |> Enum.map(&List.first/1)                          # grab the first pair (should only have one pair)
    |> Enum.map(fn({a, b}) -> div(b, a) end)            # calculate the quotient for each row
    |> Enum.sum()                                       # sum the quotients for each row
  end
end
