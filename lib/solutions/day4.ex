defmodule AOC.Solutions.Day4 do
  @moduledoc """
  Solution for Day 4 puzzle of Advent of Code (http://adventofcode.com/2017/day/4).

  ## Puzzle Usage
  In order to solve the puzzle, the input must be split by new line,
  filtered by the desired function (pass_valid?), and then counted:

  "aa bb cc\nbb cc dd\n..."
  |> String.split("\n", trim: true)
  |> Enum.filter(&AOC.Solutions.Day4.pass_valid?/1)
  |> Enum.count()
  """

  @doc """
  pass_valid? solves the following problem:
  A new system policy has been put in place that requires all
  accounts to use a passphrase instead of simply a password. A
  passphrase consists of a series of words (lowercase letters)
  separated by spaces.

  To ensure security, a valid passphrase must contain no duplicate
  words.

  ## Examples

      iex> AOC.Solutions.Day4.pass_valid? "aa bb cc dd ee"
      true

      iex> AOC.Solutions.Day4.pass_valid? "aa bb cc dd aa"
      false

      iex> AOC.Solutions.Day4.pass_valid? "aa bb cc dd aaa"
      true

  """
  @spec pass_valid?(String.t) :: boolean()
  def pass_valid?(pass) when is_bitstring(pass) do
    pass_words = Regex.split(~r{\s+}, pass)
    pass_count = Enum.count(pass_words)
    uniq_pass_count = pass_words |> Enum.uniq() |> Enum.count()

    pass_count == uniq_pass_count
  end

  @doc """
  pass_anagram_valid? solves the following problem:
  A new system policy has been put in place that requires all
  accounts to use a passphrase instead of simply a password. A
  passphrase consists of a series of words (lowercase letters)
  separated by spaces.

  To ensure security, a valid passphrase must contain no duplicate
  words.

  ## Examples

      iex> AOC.Solutions.Day4.pass_anagram_valid? "abcde fghij"
      true

      iex> AOC.Solutions.Day4.pass_anagram_valid? "abcde xyz ecdab"
      false

      iex> AOC.Solutions.Day4.pass_anagram_valid? "a ab abc abd abf abj"
      true

      iex> AOC.Solutions.Day4.pass_anagram_valid? "iiii oiii ooii oooi oooo"
      true

      iex> AOC.Solutions.Day4.pass_anagram_valid? "oiii ioii iioi iiio"
      false

  """
  @spec pass_anagram_valid?(String.t) :: boolean()
  def pass_anagram_valid?(pass) when is_bitstring(pass) do
    pass_words = Regex.split(~r{\s+}, pass)
    pass_count = Enum.count(pass_words)
    uniq_pass_count =
      pass_words
      |> Enum.map(&String.codepoints/1)
      |> Enum.map(&Enum.sort/1)
      |> Enum.map(&Enum.join/1)
      |> Enum.uniq()
      |> Enum.count()

    pass_count == uniq_pass_count
  end
end
