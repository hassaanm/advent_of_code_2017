defmodule AOC.Util.EnumTest do
  use ExUnit.Case
  doctest AOC.Util.Enum

  describe ".find_divs" do
    test "find_divs finds all pairs of divisors and dividends that divide evenly from a list of integers" do
      assert AOC.Util.Enum.find_divs([2, 4, 3, 6]) == [{2, 4}, {2, 6}, {3, 6}]
      assert AOC.Util.Enum.find_divs([3, 12, 6]) == [{3, 6}, {3, 12}, {6, 12}]
    end

    test "find_divs returns an empty list when input is empty list" do
      assert AOC.Util.Enum.find_divs([]) == []
    end

    test "find_divs returns an empty list when input only has 1 integer" do
      assert AOC.Util.Enum.find_divs([1]) == []
    end
  end

  describe ".shift" do
    test "shift rotates a list by the desired amount" do
      assert AOC.Util.Enum.shift([2, 4, 3, 6], 1) == [6, 2, 4, 3]
      assert AOC.Util.Enum.shift([3, 12, 6], 2) == [12, 6, 3]
    end

    test "shift of empty list is empty list" do
      assert AOC.Util.Enum.shift([], 1) == []
    end

    test "shift of 0 returns the same list" do
      assert AOC.Util.Enum.shift([1, 2, 3], 0) == [1, 2, 3]
    end

    test "shift of list size returns the same list" do
      assert AOC.Util.Enum.shift([1, 2, 3], 3) == [1, 2, 3]
    end

    test "shift by a negative properly rotates" do
      assert AOC.Util.Enum.shift([1, 2, 3], -1) == [2, 3, 1]
    end

    test "shift by an amount greater than size of list properly rotates" do
      assert AOC.Util.Enum.shift([1, 2, 3], 4) == [3, 1, 2]
    end
  end
end
