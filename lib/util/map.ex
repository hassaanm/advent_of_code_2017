defmodule AOC.Util.Map do
  @moduledoc """
  Utility functions for maps.
  """

  @doc """
  invert_graph inverts a graph that stored as a map.

  ## Examples

      iex> AOC.Util.Map.invert_graph(%{:a => [:b], :b => []})
      %{:a => [], :b => [:a]}

  """
  @spec invert_graph(map()) :: map()
  def invert_graph(graph) do
    # builds initial inverted graph to ensure all keys exist
    inv_graph =
      graph
      |> Map.keys()
      |> Enum.map(&({&1, []}))
      |> Enum.into(%{})

    # fills in inverted graph
    graph
    |> Map.to_list()
    |> Enum.flat_map(fn {k, vals} -> for v <- vals, do: {v, k} end)
    |> Enum.reduce(inv_graph, fn {k, v}, ig -> Map.update(ig, k, [], &([v | &1])) end)
  end

  @doc """
  sum_adj_mat gets the sum of all the adjacent values of a location
  in a 2D matrix (stored as a map). Missing values are treated as 0.

  ## Examples

      iex> AOC.Util.Map.sum_adj_mat(%{{0, 0} => 1, {0, 1} => 1}, {1, 1})
      2

  """
  @spec sum_adj_mat(map(), {integer(), integer()}) :: integer()
  def sum_adj_mat(mat, {x, y}) do
    nums =
      for x_delta <- -1..1,
          y_delta <- -1..1,
          do: Map.get(mat, {x + x_delta, y + y_delta}, 0)

    Enum.sum(nums)
  end
end
