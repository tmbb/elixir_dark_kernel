defmodule DarkKernel do
  @moduledoc """
  Documentation for `DarkKernel`.
  """
  # alias DarkKernel.DarkKeywords
  alias DarkKernel.DarkKeywords
  alias DarkKernel.ShorterMaps

  @doc """
  Supercharged keyword lists.
  """
  defmacro sigil_k(contents, modifiers) do
    DarkKeywords.do_sigil_K(contents, modifiers, __CALLER__)
  end

  @default_modifier_m ?s
  @default_modifier_M ?a

  @doc """
  Expands to a string keyed map where the keys are a string containing the
  variable names, e.g. `~m{name}` expands to `%{"name" => name}`.
  Some common uses of `~m` are when working with JSON and Regex captures, which
  use exclusively string keys in their maps.

      # JSON example:
      # Here, `~m{name, age}` expands to `%{"name" => name, "age" => age}`
      iex> ~m{name, age} = Poison.decode!("{\"name\": \"Chris\",\"age\": \"old\"}")
      %{"name" => "Chris", "age" => "old"}

      ...> name
      "Chris"

      ...> age
      "old"

  See the README for extended syntax and usage.
  """

  defmacro sigil_m(term, modifiers)

  defmacro sigil_m({:<<>>, [line: line], [string]}, modifiers) do
    ShorterMaps.do_sigil_m(string, line, modifier(modifiers, @default_modifier_m))
  end

  defmacro sigil_m({:<<>>, _, _}, _modifiers) do
    raise ArgumentError, "interpolation is not supported with the ~m sigil"
  end


  @doc ~S"""
  Expands an atom-keyed map with the given keys bound to variables with the same
  name.

  Because `~M` operates on atoms, it is compatible with Structs.

  ## Examples:
      # Map construction:
      iex> tty = "/dev/ttyUSB0"
      ...> baud = 19200
      ...> device = ~M{tty, baud}
      %{baud: 19200, tty: "/dev/ttyUSB0"}

      # Map Update:
      ...> baud = 115200
      ...> %{device|baud}
      %{baud: 115200, tty: "/dev/ttyUSB0"}

      # Struct Construction
      iex> id = 100
      ...> ~M{%Person id}
      %Person{id: 100, other_key: :default_val}

  See the README for extended syntax and usage.
  """

  defmacro sigil_M(term, modifiers)

  defmacro sigil_M({:<<>>, [line: line], [string]}, modifiers) do
    ShorterMaps.do_sigil_m(string, line, modifier(modifiers, @default_modifier_M))
  end

  defmacro sigil_M({:<<>>, _, _}, _modifiers) do
    raise ArgumentError, "interpolation is not supported with the ~M sigil"
  end

  @doc false
  defp modifier([], default), do: default
  defp modifier([mod], _default) when mod in 'as', do: mod
  defp modifier(_, _default) do
    raise(ArgumentError, "only these modifiers are supported: s, a")
  end
end
