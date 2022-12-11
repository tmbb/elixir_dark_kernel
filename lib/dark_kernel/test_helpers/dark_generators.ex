defmodule DarkKernel.TestHelpers.DarkGenerators do
  @moduledoc false

  # This module is officially a way to generate fake but valid
  # elixir variable names so that we can generate some random
  # test files for our library.
  #
  # Actually, it's an excuse to have fun with StreamData generators.
  # Random generation is implemented with StreamData generators,
  # which means that if we ever want to use these in ExUnit,
  # they will shrink correctly!
  #
  # This means the code in this file is severely overengineered.

  alias StreamData
  import DarkKernel

  def elixir_variable_name(options \\ []) do
    # NOTE: This code is much shorter with DarkKernel
    ~k[min_length: 1, max_length: 16 = options]

    # Some simple parameter validation

    if min_length > max_length do
      raise ":min_length can't be smaller than max_length"
    end

    if min_length < 1 do
      raise ":min_length must be a positive integer"
    end

    cond do
      max_length == 1 ->
        string_as(
          prefix: [chars: [?a..?z], size: 1]
        )

      min_length == 1 and max_length == 2 ->
        string_as(
          prefix: [chars: [?a..?z], size: 1],
          rest: [chars: [?a..?z, ?A..?Z, ?0..?9, ?_, ??, ?!], size: 1]
        )

      max_length > 3 ->
        # Make sure that the ?_ character is overrepresented
        # so that variable names look a bit more natural
        middle_chars = [?a..?z, ?A..?Z, ?0..?9] ++ List.duplicate(?_, 7)
        middle_min_length = max(min_length - 2, 0)
        middle_max_length = max_length - 1

        string_as(
          prefix: [chars: [?a..?z], size: 1],
          middle: [chars: middle_chars, min_length: middle_min_length, max_length: middle_max_length],
          suffix: [chars: [??, ?!], size: 1, optional: true]
        )
    end
  end

  def elixir_variable_names(n, options \\ []) do
    StreamData.uniq_list_of(
      elixir_variable_name(options),
      length: n
    )
  end

  def list_separator() do
    # The whitespace before the comma can't contain newlines!
    # That's an elixir syntax error
    string_as(
      prefix: [chars: [?\s], min_length: 0, max_length: 6, optional: true],
      comma: [chars: [?,], size: 1],
      suffix: [chars: List.duplicate(?\s, 5) ++ [?\n], min_length: 0, max_length: 6, optional: true]
    )
  end

  def string_as(parts) do
    ranges =
      for {_name, data} <- parts do
        Keyword.fetch!(data, :chars)
      end

    outer_min_and_max_lengths =
      for {_name, data} <- parts do
        case Keyword.get(data, :optional, :false) do
          true -> {0, 1}
          false -> {1, 1}
        end
      end

    range_sizes = Enum.map(ranges, &total_length/1)

    min_and_max_list_lengths =
      for {_name, data} <- parts do
        case Keyword.fetch(data, :size) do
          {:ok, size} ->
            {size, size}

          :error ->
            ~k[!min_length, !max_length = data]
            {min_length, max_length}
        end
      end

    # Zip everything together so that we can map over
    # all combinations of argument
    generator_arguments =
      outer_min_and_max_lengths
      |> Enum.zip(min_and_max_list_lengths)
      |> Enum.zip(range_sizes)

    # TODO: explain this better
    list_of_generators =
      Enum.map(
        generator_arguments,
        fn {{{outer_min, outer_max}, {inner_min, inner_max}}, size} ->
          StreamData.list_of(
            StreamData.list_of(
              StreamData.integer(0..(size-1)),
              min_length: inner_min,
              max_length: inner_max
            ),
            min_length: outer_min,
            max_length: outer_max
          )
        end)

    StreamData.map(
      StreamData.fixed_list(list_of_generators),
      fn list_of_lists_of_indices ->
        args = Enum.zip(ranges, list_of_lists_of_indices)
        charlist =
          Enum.flat_map(args, fn
            {_range, []} ->
              []

            {ranges, [list_of_indices]} ->
              Enum.map(list_of_indices, fn index -> char_at(ranges, index) end)
            end
          )

        to_string(charlist)
      end
    )
  end

  defp check_bounds!(ranges, index) do
    unless total_length(ranges) > index do
      raise "Out of bounds error"
    end
  end

  # Evaluate the total length of a sequence of ranges and single characters
  # This will be important when we want to select a random element from
  # a sequence of ranges.

  defp total_length(ranges) do
    range_sizes =
      Enum.map(ranges, fn
        %Range{} = range -> Range.size(range)
        character when is_integer(character) -> 1
      end)

    Enum.sum(range_sizes)
  end

  # Finds the character (or equivalently, the integer) in a given
  # position inside a list of ranges.
  #
  # For large ranges, this is much more efficient than enumerating
  # all values from all ranges.

  defp char_at(ranges, index) do
    check_bounds!(ranges, index)

    Enum.reduce_while(ranges, index, fn range, remainder ->
      case range do
        %Range{} ->
          unless range.step == 1 do
            raise "Invalid range #{range}. The step of the range must be 1."
          end

          min..max = range
          size = Range.size(range)

          cond do
            remainder == 0 ->
              {:halt, min}

            remainder == size - 1 ->
              {:halt, max}

            remainder < size - 1 ->
              {:halt, min + remainder}

            remainder > size - 1 ->
              {:cont, remainder - size}

          end

        c when is_integer(c) ->

          cond do
            remainder == 0 ->
              {:halt, c}

            remainder > 0 ->
              {:cont, remainder - 1}
          end
      end
    end)
  end
end
