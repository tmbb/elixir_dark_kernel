defmodule DarkKernel.TestHelpers do
  @moduledoc false

  alias DarkKernel.TestHelpers.DarkGenerators

  def elixir_variables(n, options \\ []) do
    list = Enum.take(DarkGenerators.elixir_variable_names(n, options), 100)
    Enum.random(list)
  end

  def list_separator() do
    list = Enum.take(DarkGenerators.list_separator(), 16)
    Enum.random(list)
  end

  def subset_of(enumerable, n) do
    randomized = Enum.map(enumerable, fn x -> {:rand.uniform(), x} end)
    sorted = Enum.sort(randomized)

    randomized_subset = Enum.take(sorted, n)
    Enum.map(randomized_subset, fn {_rank, x} -> x end)
  end
end
