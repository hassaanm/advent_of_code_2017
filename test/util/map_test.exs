defmodule AOC.Util.MapTest do
  use ExUnit.Case
  doctest AOC.Util.Map

  describe ".invert_graph" do
    test "invert_graph inverts a graph (map)" do
      assert AOC.Util.Map.invert_graph(%{:a => [:b], :b => [:c, :d], :c => [], :d => []})
                                        == %{:a => [], :b => [:a], :c => [:b], :d => [:b]}
    end

    test "invert_graph inverts empty graph into empty graph" do
      assert AOC.Util.Map.invert_graph(%{}) == %{}
    end

    test "invert_graph handles cyles" do
      assert AOC.Util.Map.invert_graph(%{:a => [:b], :b => [:c], :c => [:a]})
                                        == %{:a => [:c], :b => [:a], :c => [:b]}
    end
  end

  describe ".sum_adj_mat" do
    test "sum_adj_mat calculates the sum of all adjacent locations in a 2D matrix (map)" do
      assert AOC.Util.Map.sum_adj_mat(
                                      %{
                                        {-1, -1} => 1,
                                        {-1,  0} => 1,
                                        {-1,  1} => 1,
                                        { 0, -1} => 1,
                                        { 0,  1} => 1,
                                        { 1, -1} => 1,
                                        { 1,  0} => 1,
                                        { 1,  1} => 1,
                                      },
                                      {0, 0}
                                    ) == 8
    end

    test "sum_adj_mat calculates the sum of all adjacent locations in a 2D matrix (map) including itself" do
      assert AOC.Util.Map.sum_adj_mat(
                                      %{
                                        {-1, -1} => 1,
                                        {-1,  0} => 1,
                                        {-1,  1} => 1,
                                        { 0, -1} => 1,
                                        { 0,  0} => 1,
                                        { 0,  1} => 1,
                                        { 1, -1} => 1,
                                        { 1,  0} => 1,
                                        { 1,  1} => 1,
                                      },
                                      {0, 0}
                                    ) == 9
    end

    test "sum_adj_mat returns 0 when input is empty map" do
      assert AOC.Util.Map.sum_adj_mat(%{}, {0, 0}) == 0
    end
  end
end
