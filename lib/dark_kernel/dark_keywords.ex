defmodule DarkKernel.DarkKeywords do
  @moduledoc false
  require Logger

  @debug_generated_code false

  defmodule InvalidKeywordError do
    defexception [:message]

    @impl true
    def exception(text) do
      msg = """
      Invalid ~k[...] expression: ~k[#{text}]
      Keywords must be valid Elixir variable names, and the list can't be empty.
      They can be preceded by a bang (e.g. `!key`) or contain a value (e.g. `key: value`).
      Mixing bangs with keys (e.g. `!key: value`) is not allowed.
      """

      %__MODULE__{message: msg}
    end
  end

  def do_sigil_K(text_ast, modifiers, env) do
    {:<<>>, _meta, [text]} = text_ast
    # Wrap the text in brackets (e.g. [...]) and try to parse it as a list
    # with all the syntactic sugar that elixir lists support
    quoted = Code.string_to_quoted!("[#{text}]")

    unless modifiers == [] do
      raise "~k[] doesn't support modifiers"
    end

    unless is_list(quoted) do
      raise InvalidKeywordError, text
    end

    unless length(quoted) > 0 do
      raise InvalidKeywordError, text
    end

    last = List.last(quoted)

    {assignment?, normalized_list, assigned_to} =
      case last do
        # ~k[a, b, c = opts]
        {op, _meta, [left, right]} when op in [:=, :<-] ->
          list = List.delete_at(quoted, -1) ++ [left]
          {true, normalize_list(list), {:ok, right}}

        # ~k[a, b, c: default = opts]
        {key, {op, _meta, [left, right]}} when is_atom(key) and op in [:=, :<-] ->
          list = List.delete_at(quoted, -1) ++ [{key, left}]
          {true, normalize_list(list), {:ok, right}}

        _other ->
          {false, normalize_list(quoted), :error}
      end

    case {assignment?, assigned_to} do
      {false, :error} ->
        do_no_assignment(text, normalized_list, env)

      {true, {:ok, value}} ->
        do_assignment(text, normalized_list, value, env)
    end
  end

  def do_no_assignment(_text, normalized_list, _env) do
    for element <- normalized_list do
      case element do
        {:bang, _key} ->
          raise "Can't have bangs (!) unless it's an assignment expression"

        {:with_value, key, value_ast} ->
          {key, value_ast}

        {:without_value, key} ->
          unhygienic_variable = Macro.var(key, nil)
          {key, unhygienic_variable}
      end
    end
  end

  def do_assignment(tilde_k_text, normalized_list, assigned_to, env) do
    # Here we want maximum hygiene; that's why we generate a unique var
    constant = Macro.unique_var(:constant_kw_list, __MODULE__)

    initialize_constant =
      quote do
        unquote(constant) = unquote(assigned_to)
      end

    assignments =
      for element <- normalized_list do
        case element do
          {:bang, key} ->
            # No hygiene! we want to capture the user variable
            unhygienic_variable = Macro.var(key, nil)

            # Raise an error if the key doesn't exist
            quote do
              unquote(unhygienic_variable) =
                Keyword.fetch!(
                  unquote(constant),
                  unquote(key)
                )
            end

          {:with_value, key, value_ast} ->
            # No hygiene! we want to capture the user variable
            unhygienic_variable = Macro.var(key, nil)

            # Use the provided value if the key doesn't exist
            quote do
              unquote(unhygienic_variable) =
                Keyword.get(
                  unquote(constant),
                  unquote(key),
                  unquote(value_ast)
                )
            end

          {:without_value, key} ->
            # No hygiene! we want to capture the user variable
            unhygienic_variable = Macro.var(key, nil)

            # Default to nil if the key doesn't exist
            quote do
              unquote(unhygienic_variable) =
                Keyword.get(
                  unquote(constant),
                  unquote(key),
                  nil
                )
            end
        end
      end

    return_value =
      for element <- normalized_list do
        case element do
          {:bang, key} ->
            unhygienic_variable = Macro.var(key, nil)
            {key, unhygienic_variable}

          {:with_value, key, _value_ast} ->
            unhygienic_variable = Macro.var(key, nil)
            {key, unhygienic_variable}

          {:without_value, key} ->
            unhygienic_variable = Macro.var(key, nil)
            {key, unhygienic_variable}
        end
      end

    ast =
      quote do
        (
          unquote(initialize_constant)
          unquote_splicing(assignments)
          # We want warnings about unused variables
          unquote(return_value)
        )
      end

    maybe_debug_ast(tilde_k_text, ast, env)

    ast
  end

  def normalize_list(quoted) do
    for element <- quoted do
      case element do
        # Variable: [a, ...]
        {key, _meta, atom} = _var when is_atom(key) and is_atom(atom) ->
          {:without_value, key}

        # Variable with a bang: [!a, ...]
        {:!, _meta1, [{key, _meta2, atom}]} when is_atom(key) and is_atom(atom) ->
          {:bang, key}

        # Variable with a value: [a: value, ...]
        {key, value} when is_atom(key) ->
          {:with_value, key, value}
      end
    end
  end

  # ────────────────────────────────────────────────
  # Debugging
  # ────────────────────────────────────────────────

  defp maybe_debug_ast(tilde_k_text, ast, env) do
    if @debug_generated_code do
      generated_code =
        ast
        |> Macro.to_string()
        |> Code.format_string!()
        |> to_string()

      table = three_sided_cells([
        "~k[#{tilde_k_text}]",
        generated_code,
        inspect(ast, pretty: true)
      ])

      relative_filename = Path.relative_to_cwd(env.file)
      location = "#{relative_filename}:#{env.line}"

      function =
        case env.function do
          nil ->
            ""

          {fun, arity} ->
            "  ⤷ function: #{inspect(env.module)}.#{fun}/#{arity}\n"
        end

      Logger.debug([
        location,
        "\n\n",
        function,
        table
      ])
    end
  end

  # ────────────────────────────────────────────────
  # Table formatting
  # ────────────────────────────────────────────────

  @default_table_width 100

  defp three_sided_cell(content, options) do
    padding = Keyword.get(options, :padding, 1)
    width = Keyword.get(options, :width, @default_table_width)
    bottom? = Keyword.get(options, :bottom?, false)
    top? = Keyword.get(options, :top?, false)

    v_padding = List.duplicate(" │\n", padding - 1)
    h_padding = List.duplicate(" ", padding)

    nw_corner =
      case top? do
        true -> " ┌"
        false -> " ├"
      end

    sw_corner =
      case bottom? do
        true -> " └"
        false -> " ├"
      end


    as_table_cell_content =
      content
      |> String.split("\n")
      |> Enum.map(fn line -> [" │", h_padding, line, "\n"] end)

    [
      (if top?, do: [nw_corner, hline(width), "\n"], else: []),
      v_padding,
      as_table_cell_content,
      v_padding,
      [sw_corner, hline(width), "\n"],
    ]
  end

  def three_sided_cells(cells_content, options \\ []) do
    maximum_width =
      cells_content
      |> Enum.flat_map(fn line -> String.split(line, "\n") end)
      |> Enum.map(&String.length/1)
      |> Enum.max()

    width =
      case Keyword.fetch(options, :width) do
        {:ok, width} ->
          width

        :error ->
          max(@default_table_width, maximum_width)
      end

    options = Keyword.put(options, :width, width)
    nr_of_cells = length(cells_content)

    cells_with_options =
      for {cell, index} <- Enum.with_index(cells_content, 0) do
        cond do
          index == 0 ->
            {cell, Keyword.put(options, :top?, true)}

          index == nr_of_cells - 1 ->
            {cell, Keyword.put(options, :bottom?, true)}

          true ->
            {cell, options}
        end
      end

    Enum.map(cells_with_options, fn {cell, opts} ->
      three_sided_cell(cell, opts)
    end)
  end

  defp hline(width) do
    List.duplicate("─", width)
  end
end
