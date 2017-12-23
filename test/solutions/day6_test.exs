defmodule AOC.Solutions.Day6Test do
  use ExUnit.Case
  doctest AOC.Solutions.Day6

  describe ".distribute_memory" do
    test "distribute_memory calculates the number of jumps required to exit the offset list" do
      assert AOC.Solutions.Day6.distribute_memory([0, 2, 7, 0]) == [2, 4, 1, 2]
      assert AOC.Solutions.Day6.distribute_memory([2, 4, 1, 2]) == [3, 1, 2, 3]
      assert AOC.Solutions.Day6.distribute_memory([3, 1, 2, 3]) == [0, 2, 3, 4]
      assert AOC.Solutions.Day6.distribute_memory([0, 2, 3, 4]) == [1, 3, 4, 1]
      assert AOC.Solutions.Day6.distribute_memory([1, 3, 4, 1]) == [2, 4, 1, 2]
    end
  end

  describe ".inf_loop_info" do
    test "inf_loop_info calculates the number of jumps required to exit the offset list" do
      assert AOC.Solutions.Day6.inf_loop_info([0, 2, 7, 0]) == {5, 4}
    end
  end
end
