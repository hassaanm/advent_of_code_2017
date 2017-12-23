defmodule AOC.Solutions.Day7Test do
  use ExUnit.Case
  doctest AOC.Solutions.Day7

  describe ".find_bottom_tower" do
    test "find_bottom_tower finds the bottom tower in a stack" do
      assert AOC.Solutions.Day7.find_bottom_tower([
                                                    "pbga (66)",
                                                    "xhth (57)",
                                                    "ebii (61)",
                                                    "havc (66)",
                                                    "ktlj (57)",
                                                    "fwft (72) -> ktlj, cntj, xhth",
                                                    "qoyq (66)",
                                                    "padx (45) -> pbga, havc, qoyq",
                                                    "tknk (41) -> ugml, padx, fwft",
                                                    "jptl (61)",
                                                    "ugml (68) -> gyxo, ebii, jptl",
                                                    "gyxo (61)",
                                                    "cntj (57)",
                                                  ]) == "tknk"
    end
  end

  describe ".find_weight_imbalance" do
    test "find_weight_imbalance finds the weight imbalance in the towers" do
      assert AOC.Solutions.Day7.find_weight_imbalance([
                                                    "pbga (66)",
                                                    "xhth (57)",
                                                    "ebii (61)",
                                                    "havc (66)",
                                                    "ktlj (57)",
                                                    "fwft (72) -> ktlj, cntj, xhth",
                                                    "qoyq (66)",
                                                    "padx (45) -> pbga, havc, qoyq",
                                                    "tknk (41) -> ugml, padx, fwft",
                                                    "jptl (61)",
                                                    "ugml (68) -> gyxo, ebii, jptl",
                                                    "gyxo (61)",
                                                    "cntj (57)",
                                                  ]) == {251, 243}
    end
  end
end
