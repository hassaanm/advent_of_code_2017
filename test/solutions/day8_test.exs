defmodule AOC.Solutions.Day8Test do
  use ExUnit.Case
  doctest AOC.Solutions.Day8

  describe ".update_register" do
    test "update_register updates the register given a set of instructions" do
      assert AOC.Solutions.Day8.update_register(["b inc 5 if a > 1",
                                                 "a inc 1 if b < 5",
                                                 "c dec -10 if a >= 1",
                                                 "c inc -20 if c == 10"]) == %{"a" => 1, "b" => 0, "c" => -10}
    end

    test "update_register properly inserts empty values" do
      assert AOC.Solutions.Day8.update_register(["b inc 5 if a > 1"]) == %{"a" => 0, "b" => 0}
    end
  end
end
