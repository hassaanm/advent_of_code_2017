defmodule AOC.Solutions.Day2Test do
  use ExUnit.Case
  doctest AOC.Solutions.Day2

  describe ".checksum" do
    test "checksum is sum of the difference between the largest and smallest number in each row" do
      assert AOC.Solutions.Day2.checksum("0 5 9
                                          3 3 3
                                          6 7 8") == 11
    end

    test "checksum of any one digit is 0" do
      assert AOC.Solutions.Day2.checksum("3") == 0
      assert AOC.Solutions.Day2.checksum("9") == 0
    end

    test "checksum of all same digits is 0" do
      assert AOC.Solutions.Day2.checksum("3 3 3") == 0
      assert AOC.Solutions.Day2.checksum("5 5 5 5") == 0
    end

    test "checksum of rows of same digits is 0" do
      assert AOC.Solutions.Day2.checksum("1 1 1 1
                                          2 2 2 2") == 0
    end

    test "checksum ignores empty rows" do
      assert AOC.Solutions.Day2.checksum("\n\n1 1 1 1\n2 2 2 2\n") == 0
    end
  end

  describe ".checksum_div" do
    test "checksum_div is the sum of the division of the only two divisible numbers in each row" do
      assert AOC.Solutions.Day2.checksum_div("3 4 6
                                              4 8 9") == 4
    end

    test "checksum_div of rows of same digits is the number of rows" do
      assert AOC.Solutions.Day2.checksum_div("1 1 1 1
                                          2 2 2 2") == 2
    end

    test "checksum_div ignores empty rows" do
      assert AOC.Solutions.Day2.checksum_div("\n\n3 9 4\n5 7 8 2\n") == 7
    end
  end
end
