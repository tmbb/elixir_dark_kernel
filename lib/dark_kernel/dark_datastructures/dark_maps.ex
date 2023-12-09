defmodule DarkKernel.DarkDatastructures.DarkMaps do
  @moduledoc false

  alias DarkKernel.Debugger
  alias DarkKernel.DarkDatastructures.KeyValues

  @map_getter {Map, :get}
  @map_fetcher {Map, :fetch!}

  def do_sigil_m_assignment(text_ast, modifiers, rhs, env) do
    {tilde_m_text, lhs} =
      KeyValues.extract_and_parse_tilde_text!("~m{}", text_ast, modifiers, env)

    converter = fn kw_list -> {:%{}, [], kw_list} end
    key_converter = fn atom -> Atom.to_string(atom) end

    generated_ast =
      KeyValues.ast_for_assignments(
        lhs,
        rhs,
        @map_getter,
        @map_fetcher,
        converter,
        key_converter
      )

    KeyValues.debug_assignment(generated_ast, "~m{}", tilde_m_text, rhs, env)

    generated_ast
  end

  def do_sigil_m(text_ast, modifiers, env) do
    {tilde_m_text, quoted} =
      KeyValues.extract_and_parse_tilde_text!("~m{}", text_ast, modifiers, env)

    normalized_list = KeyValues.normalize_list(quoted)

    converter = fn kw_list -> {:%{}, [], kw_list} end
    key_converter = fn atom -> Atom.to_string(atom) end

    generated_ast =
      KeyValues.build_datastructure(
        normalized_list,
        tilde_m_text,
        converter,
        key_converter
      )

    code = "~m{#{tilde_m_text}}"
    Debugger.maybe_debug_ast(code, generated_ast, env)

    generated_ast
  end

  def do_sigil_M_assignment(text_ast, modifiers, rhs, env) do
    {tilde_m_text, lhs} =
      KeyValues.extract_and_parse_tilde_text!("~M{}", text_ast, modifiers, env)

    converter = fn kw_list -> {:%{}, [], kw_list} end
    key_converter = fn atom -> atom end

    generated_ast =
      KeyValues.ast_for_assignments(
        lhs,
        rhs,
        @map_getter,
        @map_fetcher,
        converter,
        key_converter
      )

    KeyValues.debug_assignment(generated_ast, "~M{}", tilde_m_text, rhs, env)

    generated_ast
  end

  def do_sigil_M(text_ast, modifiers, env) do
    {tilde_m_text, quoted} =
      KeyValues.extract_and_parse_tilde_text!("~M{}", text_ast, modifiers, env)

    normalized_list = KeyValues.normalize_list(quoted)

    converter = fn kw_list -> {:%{}, [], kw_list} end
    key_converter = fn atom -> atom end

    generated_ast =
      KeyValues.build_datastructure(
        normalized_list,
        tilde_m_text,
        converter,
        key_converter
      )

    code = "~M{#{tilde_m_text}}"
    Debugger.maybe_debug_ast(code, generated_ast, env)

    generated_ast
  end
end
