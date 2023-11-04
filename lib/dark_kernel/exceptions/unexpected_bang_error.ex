defmodule DarkKernel.Exceptions.UnexpectedBangError do
  defexception [:message]

  @impl true
  def exception(options) do
    key = Keyword.fetch!(options, :key)
    text = Keyword.fetch!(options, :text)

    msg = """
    Invalid key `#{key}` in ~m{...} expression: ~m{#{text}}
    Keywords can only be preceded by bangs (e.g. `!key`) in assignments (e.g. `~k[!#{key}] <~ value`)
    """

    %__MODULE__{message: msg}
  end
end
