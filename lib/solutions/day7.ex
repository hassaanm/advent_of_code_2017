defmodule AOC.Solutions.Day7 do
  @moduledoc """
  Solution for Day 7 puzzle of Advent of Code (http://adventofcode.com/2017/day/7).

  ## Puzzle Usage
  In order to solve the puzzle, the input must be split by new lines,
  trimmed, and then run with the desired function (find_bottom_tower):

  "input..."
  |> String.split("\n", trim: true)
  |> Enum.map(&String.trim/1)
  |> AOC.Solutions.Day7.find_bottom_tower()
  """

  @doc """
  find_bottom_tower solves the following problem:
  Wandering further through the circuits of the computer, you come upon
  a tower of programs that have gotten themselves into a bit of trouble.
  A recursive algorithm has gotten out of hand, and now they're balanced
  precariously in a large tower.

  One program at the bottom supports the entire tower. It's holding a
  large disc, and on the disc are balanced several more sub-towers. At
  the bottom of these sub-towers, standing on the bottom disc, are other
  programs, each holding their own disc, and so on. At the very tops of
  these sub-sub-sub-...-towers, many programs stand simply keeping the
  disc below them balanced but with no disc of their own.

  You offer to help, but first you need to understand the structure of
  these towers. You ask each program to yell out their name, their weight,
  and (if they're holding a disc) the names of the programs immediately
  above them balancing on that disc. You write this information down
  (your puzzle input). Unfortunately, in their panic, they don't do this
  in an orderly fashion; by the time you're done, you're not sure which
  program gave which information.

  For example, if your list is the following:

  pbga (66)
  xhth (57)
  ebii (61)
  havc (66)
  ktlj (57)
  fwft (72) -> ktlj, cntj, xhth
  qoyq (66)
  padx (45) -> pbga, havc, qoyq
  tknk (41) -> ugml, padx, fwft
  jptl (61)
  ugml (68) -> gyxo, ebii, jptl
  gyxo (61)
  cntj (57)
  ...then you would be able to recreate the structure of the towers
  that looks like this:

                  gyxo
                /
           ugml - ebii
         /      \
        |         jptl
        |
        |         pbga
       /        /
  tknk --- padx - havc
       \        \
        |         qoyq
        |
        |         ktlj
         \      /
           fwft - cntj
                \
                  xhth
  In this example, tknk is at the bottom of the tower (the bottom
  program), and is holding up ugml, padx, and fwft. Those programs
  are, in turn, holding up other programs; in this example, none
  of those programs are holding up any other programs, and are all
  the tops of their own towers. (The actual tower balancing in front
  of you is much larger.)

  ## Examples

      iex> AOC.Solutions.Day7.find_bottom_tower ["pbga (66)", "xhth (57)", "ebii (61)", "havc (66)", "ktlj (57)", "fwft (72) -> ktlj, cntj, xhth", "qoyq (66)", "padx (45) -> pbga, havc, qoyq", "tknk (41) -> ugml, padx, fwft", "jptl (61)", "ugml (68) -> gyxo, ebii, jptl", "gyxo (61)", "cntj (57)"]
      "tknk"

  """
  @spec find_bottom_tower([String.t]) :: String.t
  def find_bottom_tower(towers) when is_list(towers) do
    towers
    |> Enum.map(&(if String.contains?(&1, "->"), do: &1, else: &1 <> " -> ")) # ensure all towers have "->"
    |> Enum.map(&(String.split(&1, " -> ")))                                  # map to tower and stacks pairs
    |> Enum.map(fn [tower, stack] ->                                          # convert the stacks to a list
         tower_name = tower |> String.split() |> List.first()
         stack_list = String.split(stack, ", ", trim: true)
         {tower_name, stack_list}
       end)
    |> Enum.into(%{})                                                         # convert into a map
    |> AOC.Util.Map.invert_graph()                                            # invert graph
    |> Map.to_list()                                                          # convert to list
    |> Enum.reduce_while("", fn {k, v}, _ ->                                  # find tower with dependency
         if v == [], do: {:halt, k}, else: {:cont, ""}
       end)
  end

  @doc """
  find_weight_imbalance solves the following problem:
  The programs explain the situation: they can't get down. Rather, they
  could get down, if they weren't expending all of their energy trying
  to keep the tower balanced. Apparently, one program has the wrong weight,
  and until it's fixed, they're stuck here.

  For any program holding a disc, each program standing on that disc forms
  a sub-tower. Each of those sub-towers are supposed to be the same weight,
  or the disc itself isn't balanced. The weight of a tower is the sum of
  the weights of the programs in that tower.

  In the example above, this means that for ugml's disc to be balanced,
  gyxo, ebii, and jptl must all have the same weight, and they do: 61.

  However, for tknk to be balanced, each of the programs standing on its
  disc and all programs above it must each match. This means that the
  following sums must all be the same:

  ugml + (gyxo + ebii + jptl) = 68 + (61 + 61 + 61) = 251
  padx + (pbga + havc + qoyq) = 45 + (66 + 66 + 66) = 243
  fwft + (ktlj + cntj + xhth) = 72 + (57 + 57 + 57) = 243
  As you can see, tknk's disc is unbalanced: ugml's stack is heavier
  than the other two. Even though the nodes above ugml are balanced,
  ugml itself is too heavy: it needs to be 8 units lighter for its
  stack to weigh 243 and keep the towers balanced. If this change were
  made, its weight would be 60.

  Output is {imbalanced_weight, balanced_weight}.

  ## Examples

      iex> AOC.Solutions.Day7.find_weight_imbalance ["pbga (66)", "xhth (57)", "ebii (61)", "havc (66)", "ktlj (57)", "fwft (72) -> ktlj, cntj, xhth", "qoyq (66)", "padx (45) -> pbga, havc, qoyq", "tknk (41) -> ugml, padx, fwft", "jptl (61)", "ugml (68) -> gyxo, ebii, jptl", "gyxo (61)", "cntj (57)"]
      {68, 60}

  """
  @spec find_weight_imbalance([String.t]) :: {integer(), integer()}
  def find_weight_imbalance(towers) when is_list(towers) do
    bottom = find_bottom_tower towers

    weight_graph =
      towers
      |> Enum.map(&(if String.contains?(&1, "->"), do: &1, else: &1 <> " -> ")) # ensure all towers have "->"
      |> Enum.map(&(String.split(&1, " -> ")))                                  # map to tower and stacks pairs
      |> Enum.map(fn [tower, stack] ->                                          # convert to tuple of weight
           [name, weight] = String.split(tower)                                 # and stack list
           weight_num = Regex.run(~r{\d+}, weight) |> List.first() |> String.to_integer()
           stack_list = String.split(stack, ", ", trim: true)
           {name, {weight_num, stack_list}}
         end)
      |> Enum.into(%{})                                                         # put into map

    {balance, weights} = fwi_helper(Map.get(weight_graph, bottom), weight_graph)

    # fwi_helper should either find the imbalance or
    # the imbalance is at the bottom tower, in which
    # case we have to determine the imbalance
    if balance == :imbalanced do
      weights
    else
      {_, ws} = weights
      weight_counts = Enum.reduce(ws, %{}, fn {_, w}, m -> Map.update(m, w, 1, &(&1 + 1)) end)
      {imb_weight, _} = Enum.min_by(weight_counts, fn {_, x} -> x end)
      {bal_weight, _} = Enum.max_by(weight_counts, fn {_, x} -> x end)
      {imb_tower_weight, _} = Enum.find(ws, fn {_, x} -> x == imb_weight end)
      {imb_tower_weight, imb_tower_weight + bal_weight - imb_weight}
    end
  end

  @spec fwi_helper({integer(), [String.t]}, map()) :: {atom(), any()}
  defp fwi_helper({weight, []}, _), do: {:balanced, {weight, weight}}
  defp fwi_helper({weight, stack}, weight_graph) do
    # make recursive calls to find weights
    balance_info =
      stack
      |> Enum.map(&(fwi_helper(Map.get(weight_graph, &1), weight_graph)))

    cond do
      # if imbalance exists in recursive calls, return it
      imb = Enum.find(balance_info, fn {b, _} -> b == :imbalanced end) ->
        imb

      # if imbalance has been found but not calculated, calculate it and return it
      find_imb = Enum.find(balance_info, fn {b, _} -> b == :find_imbalance end) ->
        # find the expected weight
        {_, {_, exp_weight}} = Enum.find(balance_info, fn {b, _} -> b == :balanced end)

        # find the imbalanced tower
        {_, {w, w_list}} = find_imb
        w_list_size = Enum.count(w_list)
        {imb_tower_weight, imb_weight} = Enum.find(w_list, fn {_, x} -> x * w_list_size != exp_weight - w end)
        {_, bal_weight} = Enum.find(w_list, fn {_, x} -> x * w_list_size == exp_weight - w end)

        {:imbalanced, {imb_tower_weight, imb_tower_weight + bal_weight - imb_weight}}

      # if everything is balanced, calculate the total weight and return it
      balance_info |> Enum.uniq_by(fn {_, {_, w}} -> w end) |> Enum.count() == 1 ->
        {:balanced, {weight, weight + Enum.reduce(balance_info, 0, fn {_, {_, w}}, acc -> w + acc end)}}

      # otherwise, we have found the imbalance
      # it needs to be calculated at the next level to account for 2 sub tower case
      true ->
        {:find_imbalance, {weight, Enum.map(balance_info, fn {_, w} -> w end)}}
    end
  end
end
