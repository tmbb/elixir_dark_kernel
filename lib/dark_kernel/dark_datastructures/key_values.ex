defmodule DarkKernel.DarkDatastructures.KeyValues do
  @moduledoc false

  alias DarkKernel.Debugger

  alias DarkKernel.Exceptions.{
    InvalidKeywordError,
    UnexpectedBangError
  }

  def ast_for_assignments(lhs, rhs, getter, fetcher, converter, key_converter) do
    normalized_list = normalize_list(lhs)

    {initialize_constant, variable_assignments} =
      build_assignments(
        getter,
        fetcher,
        rhs,
        normalized_list,
        key_converter
      )

    return_value = assignment_result_value(converter, key_converter, normalized_list)

    generated_ast =
      quote do
        # Wrap it all in a block so that it counts as a single expression
        # Assign the right hand side to a (constant) variable
        # so that it doesn't get evaluated more than once
        unquote(initialize_constant)
        # Assing the variables defined by the left hand side
        unquote_splicing(variable_assignments)
        # Return the final datastructure
        unquote(return_value)
      end

    generated_ast
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

  def build_datastructure(normalized_list, tilde_text, datastructure_converter, key_converter) do
    generated_ast =
      for element <- normalized_list do
        case element do
          {:bang, key} when is_atom(key) ->
            raise UnexpectedBangError, key: key, text: tilde_text

          {:with_value, key, value_ast} when is_atom(key) ->
            {key_converter.(key), value_ast}

          {:without_value, key} when is_atom(key) ->
            unhygienic_variable = Macro.var(key, nil)
            {key_converter.(key), unhygienic_variable}
        end
      end

    datastructure_converter.(generated_ast)
  end

  def build_assignments(getter, fetcher, rhs, normalized_list, key_converter) do
    {getter_mod, getter_fun} = getter
    {fetcher_mod, fetcher_fun} = fetcher
    # Here we want maximum hygiene; that's why we generate a unique var
    constant = Macro.unique_var(:constant_kw_list, __MODULE__)

    initialize_constant =
      quote do
        unquote(constant) = unquote(rhs)
      end

    assignments =
      for element <- normalized_list do
        case element do
          {:bang, key} when is_atom(key) ->
            # No hygiene! we want to capture the user variable
            unhygienic_variable = Macro.var(key, nil)
            # Raise an error if the key doesn't exist
            quote do
              unquote(unhygienic_variable) =
                unquote(fetcher_mod).unquote(fetcher_fun)(
                  unquote(constant),
                  unquote(key_converter.(key))
                )
            end

          {:with_value, key, value_ast} when is_atom(key) ->
            unhygienic_variable = Macro.var(key, nil)
            # Use the provided value if the key doesn't exist
            quote do
              unquote(unhygienic_variable) =
                unquote(getter_mod).unquote(getter_fun)(
                  unquote(constant),
                  unquote(key_converter.(key)),
                  unquote(value_ast)
                )
            end

          {:without_value, key} when is_atom(key) ->
            unhygienic_variable = Macro.var(key, nil)
            # Default to nil if the key doesn't exist
            quote do
              unquote(unhygienic_variable) =
                unquote(getter_mod).unquote(getter_fun)(
                  unquote(constant),
                  unquote(key_converter.(key)),
                  nil
                )
            end
        end
      end

    {initialize_constant, assignments}
  end

  def assignment_result_value(datastructure_converter, key_converter, normalized_list) do
    keyword_list =
      for element <- normalized_list do
        case element do
          {:bang, key} when is_atom(key) ->
            # No hygiene! we want to capture the user variable
            unhygienic_variable = Macro.var(key, nil)
            {key_converter.(key), unhygienic_variable}

          {:with_value, key, _value_ast} when is_atom(key) ->
            unhygienic_variable = Macro.var(key, nil)
            {key_converter.(key), unhygienic_variable}

          {:without_value, key} when is_atom(key) ->
            unhygienic_variable = Macro.var(key, nil)
            {key_converter.(key), unhygienic_variable}
        end
      end

    datastructure_converter.(keyword_list)
  end

  def extract_and_parse_tilde_text!(sigil, text_ast, modifiers, _env) do
    {:<<>>, _meta, [tilde_text]} = text_ast
    # Wrap the text in brackets (e.g. [...]) and try to parse it as a list
    # with all the syntactic sugar that elixir lists support
    quoted = Code.string_to_quoted!("[#{tilde_text}]")

    unless modifiers == [] do
      raise CompileError, "#{sigil} doesn't support modifiers"
    end

    unless is_list(quoted) and length(quoted) > 0 do
      raise InvalidKeywordError, sigil: sigil, text: tilde_text
    end

    {tilde_text, quoted}
  end

  def debug_assignment(generated_ast, sigil, tilde_text, rhs, env) do
    <<?~::8, letter::8, left_delim::8, right_delim::8>> = sigil

    letter = <<letter::8>>
    left_delim = <<left_delim::8>>
    right_delim = <<right_delim::8>>

    rhs_as_text =
      rhs
      |> Macro.to_string()
      |> Code.format_string!()

    code = "~#{letter}#{left_delim}#{tilde_text}#{right_delim} <~ #{rhs_as_text}"
    Debugger.maybe_debug_ast(code, generated_ast, env)

    :ok
  end
end
