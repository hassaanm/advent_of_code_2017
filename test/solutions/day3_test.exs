defmodule AOC.Solutions.Day3Test do
  use ExUnit.Case
  doctest AOC.Solutions.Day3

  describe ".spiral_man_dist" do
    test "spiral_man_dist is the number of steps from 1 to any number in spiral formation" do
      assert AOC.Solutions.Day3.spiral_man_dist(1) == 0
      assert AOC.Solutions.Day3.spiral_man_dist(7) == 2
      assert AOC.Solutions.Day3.spiral_man_dist(34) == 3
    end
  end

  describe ".next_spiral_num" do
    test "next_spiral_num is the number in spiral formation that is greater than the input" do
      assert AOC.Solutions.Day3.next_spiral_num(7) == 10
      assert AOC.Solutions.Day3.next_spiral_num(55) == 57
      assert AOC.Solutions.Day3.next_spiral_num(144) == 147
      assert AOC.Solutions.Day3.next_spiral_num(800) == 806
    end
  end
end
