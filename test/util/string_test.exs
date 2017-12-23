defmodule AOC.Util.StringTest do
  use ExUnit.Case
  doctest AOC.Util.String

  describe ".num_row_to_num_list" do
    test "num_row_to_num_list converts a string of numbers to a list of integers" do
      assert AOC.Util.String.num_row_to_num_list("1 2 3") == [1, 2, 3]
    end

    test "num_row_to_num_list ignores various whitespace" do
      assert AOC.Util.String.num_row_to_num_list(" 1    2  3 ") == [1, 2, 3]
    end
  end
end
