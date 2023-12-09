defmodule DarkKernel.DarkMutable do
  @moduledoc false

  alias DarkKernel.Debugger

  def __set__(ref, value) do
    Process.put(ref, value)
  end

  def __get__(ref) do
    Process.get(ref)
  end

  def __delete__(ref) do
    Process.delete(ref)
  end

  def replace_variable_access(var_names, ast) do
    # Step 1: tag all "naturally occurring" mutable variables
    # by encasing them in a 2-tuple (why a 2-tuple? because elixir's AST
    # makes it very easy to manipulate 2-tuples)
    ast_v1 =
      Macro.postwalk(ast, fn ast_node ->
        case ast_node do
          {var_name, _meta, nil} = var ->
            if var_name in var_names do
              quote do
                {:DARK_MUTABLE_VARIABLE, unquote(var)}
              end
            else
              ast_node
            end

          other ->
            other
        end
      end)

    # Step 2: rewrite all mutable variable assignments
    ast_v2 =
      Macro.postwalk(ast_v1, fn ast_node ->
        case ast_node do
          {:<<~, _meta1,
           [{:DARK_MUTABLE_VARIABLE, {var_name, _meta2, nil} = var}, right_hand_side]} ->
            if var_name in var_names do
              quote do
                DarkKernel.DarkMutable.__set__(unquote(var), unquote(right_hand_side))
              end
            else
              ast_node
            end

          other ->
            other
        end
      end)

    # Step 3: rewrite all mutable references.
    # This is where it helps to have the extra tags...
    # Every variable reference still encased in a 2-tuple
    # is actually a reference thet should be replaced with __get__!
    ast_v3 =
      Macro.postwalk(ast_v2, fn ast_node ->
        case ast_node do
          {:DARK_MUTABLE_VARIABLE, {var_name, _meta, nil} = var} ->
            if var_name in var_names do
              quote do
                DarkKernel.DarkMutable.__get__(unquote(var))
              end
            else
              ast_node
            end

          other ->
            other
        end
      end)

    ast_v3
  end

  def do_mutable!(caller, variables, do: body) do
    variable_names = for {name, _value} <- variables, do: name

    # Do not transform this AST!
    # This part is already written using proper references
    reference_definition =
      for {name, _value} <- variables do
        quote do
          unquote(Macro.var(name, nil)) = make_ref()
        end
      end

    reference_assignments =
      for {name, value} <- variables do
        quote do
          DarkKernel.DarkMutable.__set__(unquote(Macro.var(name, nil)), unquote(value))
        end
      end

    mutable_variable_setup = reference_definition ++ reference_assignments

    mutable_variable_cleanup =
      for {name, _value} <- variables do
        quote do
          DarkKernel.DarkMutable.__delete__(unquote(Macro.var(name, nil)))
        end
      end

    rewritten_body = replace_variable_access(variable_names, body)

    generated_ast =
      quote do
        # References must be defined outside the try block so that they can be acessible
        # in the after block for cleanup
        unquote_splicing(reference_definition)

        try do
          # Assign the references inside the try block, because assigning the references
          # may cause an error
          unquote_splicing(reference_assignments)
          unquote(rewritten_body)
        after
          # Cleanup the references so that the "mutable variables"
          # can not be used outside this block
          (unquote_splicing(mutable_variable_cleanup))
        end
      end

    code =
      rewritten_body
      |> Macro.to_string()
      |> Code.format_string!()
      |> IO.iodata_to_binary()

    Debugger.maybe_debug_ast(code, generated_ast, caller)

    generated_ast
  end
end
