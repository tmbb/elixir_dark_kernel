defmodule DarkKernel.DarkDatastructures.DarkKeywords do
  @moduledoc false
  alias DarkKernel.Debugger
  alias DarkKernel.DarkDatastructures.KeyValues

  @keyword_getter {Keyword, :get}
  @keyword_fetcher {Keyword, :fetch!}

  def do_sigil_k_assignment(text_ast, modifiers, rhs, env) do
    {tilde_m_text, lhs} =
      KeyValues.extract_and_parse_tilde_text!("~m{}", text_ast, modifiers, env)

    # Don't convert anything!
    # We'll generate a valid Keyword list AST
    converter = fn kw_list -> kw_list end
    key_converter = fn atom -> atom end

    generated_ast =
      KeyValues.ast_for_assignments(
        lhs,
        rhs,
        @keyword_getter,
        @keyword_fetcher,
        converter,
        key_converter
      )

    KeyValues.debug_assignment(generated_ast, "~k{}", tilde_m_text, rhs, env)

    generated_ast
  end

  def do_sigil_k(text_ast, modifiers, env) do
    {tilde_m_text, quoted} =
      KeyValues.extract_and_parse_tilde_text!("~k{}", text_ast, modifiers, env)

    normalized_list = KeyValues.normalize_list(quoted)

    # Don't convert anything!
    # We'll generate a valid Keyword list AST
    converter = fn kw_list -> kw_list end
    key_converter = fn atom -> atom end

    generated_ast =
      KeyValues.build_datastructure(
        normalized_list,
        tilde_m_text,
        converter,
        key_converter
      )

    code = "~k{#{tilde_m_text}}"
    Debugger.maybe_debug_ast(code, generated_ast, env)

    generated_ast
  end
end
