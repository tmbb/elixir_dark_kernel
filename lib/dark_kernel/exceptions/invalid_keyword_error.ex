defmodule DarkKernel.Exceptions.InvalidKeywordError do
  defexception [:message]

  @impl true
  def exception(data) do
    sigil = Keyword.fetch!(data, :sigil)
    text = Keyword.fetch!(data, :text)

    <<?~::8, letter::8, left_delim::8, right_delim::8>> = sigil

    letter = <<letter::8>>
    left_delim = <<left_delim::8>>
    right_delim = <<right_delim::8>>

    expression = fn content -> "~#{letter}#{left_delim}#{content}#{right_delim}" end

    msg = """
    Invalid #{expression.("...")} expression: #{expression.(text)}
    Keywords must be valid Elixir variable names, and the map can't be empty.
    If part of an assignment, keys can be preceded by a bang (e.g. `!key`) or contain a value (e.g. `key: value`).
    Mixing bangs with keys (e.g. `!key: value`) is not allowed.
    """

    %__MODULE__{message: msg}
  end
end
