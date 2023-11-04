defmodule DarkKernel do
  @moduledoc """
  Documentation for `DarkKernel`.
  """
  alias DarkKernel.DarkFractions
  alias DarkKernel.DarkDatastructures.DarkKeywords
  alias DarkKernel.DarkDatastructures.DarkMaps

  defmodule DarkAssignmentError do
    defexception [:message]

    @impl true
    def exception(options) do
      left =
        Keyword.fetch!(options, :left)
        |> Macro.to_string()
        |> Code.format_string!()

      right =
        Keyword.fetch!(options, :right)
        |> Macro.to_string()
        |> Code.format_string!()

      msg = """
      The left hand side of '<~' must be one of the following sigils: ~k[], ~m{} or ~M{}
      The following arguments were given:

        * Left hand side: #{left}
        * Right hand side: [#{right}]
      """

      %__MODULE__{message: msg}
    end
  end

  @doc """
  Assign values in a dark map or dark keyword list.
  """
  defmacro left <~ right do
    case left do
      {:sigil_k, _meta, [contents, modifiers]} ->
        DarkKeywords.do_sigil_k_assignment(contents, modifiers, right, __CALLER__)

      {:sigil_m, _meta, [contents, modifiers]} ->
        DarkMaps.do_sigil_m_assignment(contents, modifiers, right, __CALLER__)

      {:sigil_M, _meta, [contents, modifiers]} ->
        DarkMaps.do_sigil_M_assignment(contents, modifiers, right, __CALLER__)

      _other ->
        raise DarkAssignmentError, left: left, right: right
    end
  end

  @doc """
  Supercharged keyword lists.
  """
  defmacro sigil_k({:<<>>, _, [_string]} = contents, modifiers) do
    DarkKeywords.do_sigil_k(contents, modifiers, __CALLER__)
  end

  defmacro sigil_k({:<<>>, _, _}, _modifiers) do
    raise ArgumentError, "interpolation is not supported with the ~k sigil"
  end

  @doc """
  Expands to a string keyed map where the keys are a string containing the
  variable names, e.g. `~m{name}` expands to `%{"name" => name}`.
  Some KeyValues uses of `~m` are when working with JSON and Regex captures, which
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
  defmacro sigil_m({:<<>>, _, [_string]} = contents, modifiers) do
    DarkMaps.do_sigil_m(contents, modifiers, __CALLER__)
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
  defmacro sigil_M({:<<>>, _, [_string]} = contents, modifiers) do
    DarkMaps.do_sigil_M(contents, modifiers, __CALLER__)
  end

  defmacro sigil_M({:<<>>, _, _}, _modifiers) do
    raise ArgumentError, "interpolation is not supported with the ~M sigil"
  end

  defmacro sigil_f({:<<>>, _, [_string]} = contents, modifiers) do
    DarkFractions.do_sigil_f(contents, modifiers, __CALLER__)
  end

  defmacro sigil_f({:<<>>, _, _}, _modifiers) do
    raise ArgumentError, "interpolation is not supported with the ~M sigil"
  end
end
