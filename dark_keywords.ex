defmodule DarkKernel.DarkKeywords do

  defmodule InvalidKeywordError do
    defexception [:message]

    @impl true
    def exception(invalid_word) do
      msg = """
      Invalid keyword: #{invalid_word}
      Keywords must be valid Elixir variable names and contain only ASCII characters.
      """

      %__MODULE__{message: msg}
    end
  end

  defp parse_keywords(text) do
    words =
      text
      |> String.split(",")
      |> Enum.map(&String.trim/1)

    for word <- words do
      unless word =~ ~r/^[a-z][A-Za-z0-9_]*[!?]?$/ do
        raise InvalidKeywordError, word
      end
    end

    words
  end

  def build_keyword_match(expression, words) do
    constant_kwlist = Macro.unique_var(:constant_kwlist, __MODULE__)

    constant_assignment =
      quote do
        unquote(constant_kwlist) = unquote(expression)
      end

    assignments =
      for {tag, word} <- words do
        atom_key = String.to_atom(word)
        variable = Macro.var(atom_key, nil)
        atom_key, variable

        case tag do
          :get ->
            quote do
              unquote(variable) = Keyword.get(unquote(constant_kwlist), unquote(atom_key))
            end

          :fetch ->
            quote do
              unquote(variable) = Keyword.fetch!(unquote(constant_kwlist), unquote(atom_key))
            end
        end
      end

    ast =
      quote do
        unquote(constant_assignment)
        unquote_splicing(assignments)
      end

    ast |> Code.format_string() |> IO.puts()

    ast
  end

  defp build_keyword_list(words) do
    for word <- words do
      atom_key = String.to_atom(word)
      variable = Macro.var(atom_key, nil)
      {atom_key, variable}
    end
  end

  defmacro sigil_k(text_ast, _modifiers) do
    {:<<>>, _meta, [text]} = text_ast
    words = parse_keywords(text)
    keyword_list_ast = build_keyword_list(words)

    keyword_list_ast
  end
end
