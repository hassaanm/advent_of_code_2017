defmodule AOC.Solutions.Day5Test do
  use ExUnit.Case
  doctest AOC.Solutions.Day5

  describe ".jump_steps" do
    test "jump_steps calculates the number of jumps required to exit the offset list" do
      assert AOC.Solutions.Day5.jump_steps([0, 3, 0, 1, -3]) == 5
    end
  end

  describe ".bi_jump_steps" do
    test "bi_jump_steps calculates the number of jumps required to exit the offset list" do
      assert AOC.Solutions.Day5.bi_jump_steps([0, 3, 0, 1, -3]) == 10
    end
  end
end
