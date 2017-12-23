defmodule AOC.Util.String do
  @moduledoc """
  Utility functions for strings.
  """

  @doc """
  num_row_to_num_list turns a string of numbers delimited
  by whitespace into a list of integers.

  ## Examples

      iex> AOC.Util.String.num_row_to_num_list " 5    1  9   5  "
      [5, 1, 9, 5]

  """
  @spec num_row_to_num_list(String.t) :: [integer()]
  def num_row_to_num_list(num_row) when is_bitstring(num_row) do
    num_row
    |> String.split(" ", trim: true)
    |> Enum.map(&String.to_integer/1)
  end
end
