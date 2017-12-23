defmodule AOC.Solutions.Day4Test do
  use ExUnit.Case
  doctest AOC.Solutions.Day4

  describe ".pass_valid?" do
    test "pass_valid? determines if the given pass phrase only contains unique words" do
      assert AOC.Solutions.Day4.pass_valid?("aa bb cc") == true
      assert AOC.Solutions.Day4.pass_valid?("aa bb aa") == false
    end

    test "pass_valid? returns true for empty string" do
      assert AOC.Solutions.Day4.pass_valid?("") == true
    end

    test "pass_valid? return true for pass phrases with substring" do
      assert AOC.Solutions.Day4.pass_valid?("aa bb aaa") == true
    end
  end

  describe ".pass_anagram_valid?" do
    test "pass_anagram_valid? determines if the given pass phrase doesn't contain anagrams" do
      assert AOC.Solutions.Day4.pass_anagram_valid?("aa bb cc") == true
      assert AOC.Solutions.Day4.pass_anagram_valid?("aa bb aa") == false
      assert AOC.Solutions.Day4.pass_anagram_valid?("aabc baac") == false
    end

    test "pass_anagram_valid? returns true for empty string" do
      assert AOC.Solutions.Day4.pass_anagram_valid?("") == true
    end

    test "pass_anagram_valid? return true for pass phrases with substring" do
      assert AOC.Solutions.Day4.pass_anagram_valid?("aa bb aaa") == true
    end
  end
end
