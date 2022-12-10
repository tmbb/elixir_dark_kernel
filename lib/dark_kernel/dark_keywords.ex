defmodule DarkKernel.DarkKeywords do
  @moduledoc false
  require Logger

  @debug_generated_code false

  @bang_keyword_re ~r/![a-z][A-Za-z0-9_]*[!?]?$/
  @keyword_without_default_re ~r/^[a-z][A-Za-z0-9_]*[!?]?$/
  @keyword_with_default_re ~r/^(?<key>[a-z][A-Za-z0-9_]*[!?]?):\s+(?<default>.+)$/

  defmodule InvalidKeywordError do
    defexception [:message]

    @impl true
    def exception(invalid_word) do
      msg = """
      Invalid keyword: #{invalid_word}
      Keywords must be valid Elixir variable names and contain only ASCII characters.
      They can be preceded by a bang (e.g. `!key`) or contain a default value (e.g. `key: default`).
      """

      %__MODULE__{message: msg}
    end
  end

  defmodule InvalidKeywordMatchExpressionError do
    defexception [:message]

    @impl true
    def exception(text) do
      msg = """
      Invalid dark keyword match expression: ~k[#{text}].
      Match expressions can't contain more than one equals (=) sign.
      """

      %__MODULE__{message: msg}
    end
  end

  defmacro sigil_k(contents, modifiers) do
    do_sigil_k(contents, modifiers)
  end

  def do_sigil_k(text_ast, _modifiers) do
    {:<<>>, _meta, [text]} = text_ast
    # Decide whether it's a matching expression or not.
    # If the text contains the ?= character, it's a matching expression
    if String.contains?(text, "=") do
      # Expand as normal keyword
      do_match_keywords(text)
    else
      # Expand as matching expression
      do_normal_keywords(text)
    end
  end

  # ------------------------------------------------------
  # Normal keywords
  # ------------------------------------------------------

  def do_normal_keywords(text) do
    words = parse_keywords(text)
    build_keyword_list(words)
  end

  defp parse_keywords(text) do
    words =
      text
      |> String.split(",")
      |> Enum.map(&String.trim/1)

    for word <- words do
      unless word =~ @keyword_without_default_re do
        raise InvalidKeywordError, word
      end
    end

    words
  end

  # ------------------------------------------------------
  # Keyword matches
  # ------------------------------------------------------

  defp parse_keyword_match(text) do
    {left, right} =
      case String.split(text, "=") do
        [left, right] ->
          {left, right}

        _other ->
          raise InvalidKeywordMatchExpressionError, text
      end

    left = String.trim(left)
    right = String.trim(right)

    words =
      left
      |> String.split(",")
      |> Enum.map(&String.trim/1)

    for word <- words do
      # NOTE: in a matching ~k[] expression, words
      # can start with a `!` character
      bang_keyword? = (word =~ @bang_keyword_re)
      keyword_with_default? = (word =~ @keyword_with_default_re)
      keyword_without_default? = (word =~ @keyword_without_default_re)

      valid_keyword? =
          bang_keyword? or
          keyword_with_default? or
          keyword_without_default?

      unless valid_keyword? do
        raise InvalidKeywordError, word
      end
    end

    words =
      for word <- words do
        case word do
          "!" <> rest -> {:fetch, {rest, "nil"}}
          other ->
            case Regex.named_captures(@keyword_with_default_re, word) do
              nil ->
                {:get, {other, "nil"}}

              %{"key" => key, "default" => default} ->
                {:get, {key, default}}
            end
        end
      end

    {right, words}
  end

  defp build_keyword_match(matched, words) do
    matched_expression = Macro.var(String.to_atom(matched), nil)
    matched_constant = Macro.unique_var(:matched_constant, __MODULE__)

    keywords = for {_tag, {word, _default}} <- words, do: word

    assignments =
      for {tag, {word, default}} <- words do
        default_ast = Code.string_to_quoted!(default)
        atom_key = String.to_atom(word)
        variable = Macro.var(atom_key, nil)

        case tag do
          :get ->
            quote do
              unquote(variable) =
                Keyword.get(
                  unquote(matched_constant),
                  unquote(atom_key),
                  unquote(default_ast)
                )
            end

          :fetch ->
            quote do
              unquote(variable) =
                Keyword.fetch!(
                  unquote(matched_constant),
                  unquote(atom_key)
                )
            end
        end
      end

    return_value = build_keyword_list(keywords)

    ast =
      quote do
        (
          unquote(matched_constant) = unquote(matched_expression);
          unquote_splicing(assignments);
          _ = unquote(return_value)
        )
      end

    maybe_debug_ast(ast)

    ast
  end

  # ------------------------------------------------------
  # Utilities
  # ------------------------------------------------------

  def do_match_keywords(text) do
    {matched, words} = parse_keyword_match(text)
    build_keyword_match(matched, words)
  end

  defp build_keyword_list(words) do
    for word <- words do
      atom_key = String.to_atom(word)
      variable = Macro.var(atom_key, nil)
      {atom_key, variable}
    end
  end

  defp maybe_debug_ast(ast) do
    if @debug_generated_code do
      generated_code =
      ast
        |> Macro.to_string()
        |> Code.format_string!()

      Logger.debug([
        "\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n",
        generated_code,
        "\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
      ])
    end
  end
end
