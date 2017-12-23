defmodule AOC.Solutions.Day1 do
  @moduledoc """
  Solution for Day 1 puzzle of Advent of Code (http://adventofcode.com/2017/day/1).
  """

  @doc """
  sum_captcha solves the following problem:
  The captcha requires you to review a sequence of digits (your puzzle input)
  and find the sum of all digits that match the next digit in the list. The list
  is circular, so the digit after the last digit is the first digit in the list.

  ## Examples

      iex> AOC.Solutions.Day1.sum_captcha "1122"
      3

      iex> AOC.Solutions.Day1.sum_captcha "1111"
      4

      iex> AOC.Solutions.Day1.sum_captcha "1234"
      0

      iex> AOC.Solutions.Day1.sum_captcha "91212129"
      9

  """
  @spec sum_captcha(String.t) :: integer()
  def sum_captcha(""), do: 0
  def sum_captcha(num_str) when is_bitstring(num_str) do
    num_str <> String.first(num_str)                  # append first number to account for wrapping
    |> String.codepoints()                            # get list of single digits as strings
    |> Enum.map(&String.to_integer/1)                 # map single digit strings to integers
    |> Enum.chunk_every(2, 1, :discard)               # get list of all neighbor digits
    |> Enum.filter(fn([a, b]) -> a == b end)          # remove all non matching neighbors
    |> Enum.reduce(0, fn([a, a], acc) -> a + acc end) # sum the list of numbers
  end

  @doc """
  sum_captcha_half solves the following problem:
  Now, instead of considering the next digit, it wants you to consider the digit
  halfway around the circular list. That is, if your list contains 10 items,
  only include a digit in your sum if the digit 10/2 = 5 steps forward matches
  it. Fortunately, your list has an even number of elements.

  ## Examples

      iex> AOC.Solutions.Day1.sum_captcha_half "1212"
      6

      iex> AOC.Solutions.Day1.sum_captcha_half "1221"
      0

      iex> AOC.Solutions.Day1.sum_captcha_half "123425"
      4

      iex> AOC.Solutions.Day1.sum_captcha_half "123123"
      12

      iex> AOC.Solutions.Day1.sum_captcha_half "12131415"
      4

  """
  @spec sum_captcha_half(String.t) :: integer()
  def sum_captcha_half(""), do: 0
  def sum_captcha_half(num_str) when is_bitstring(num_str) do
    # determine the (size / 2) of the number
    half_size =
      num_str
      |> String.length()
      |> div(2)

    # split the list of numbers into 2 halves
    {first, second} =
      num_str
      |> String.codepoints()
      |> Enum.map(&String.to_integer/1)
      |> Enum.split(half_size)

    first
    |> Enum.zip(second)                                   # zip the two halves together
    |> Enum.filter(fn({a, b}) -> a == b end)              # remove all non matching pairs
    |> Enum.reduce(0, fn({a, a}, acc) -> a + a + acc end) # sum the list of numbers (count twice for both halves)
  end
end
