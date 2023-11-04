defmodule DarkKernel.DarkFractions do
  @doc """
  Sigil for fractions. Compiles to `Rational.new/2`.
  """
  def do_sigil_f({:<<>>, _meta, [text]} = _content, _modifiers, _env) do
    case Code.string_to_quoted!(text) do
      {:/, _meta, [numerator, denominator]} ->
        quote do
          Ratio.new(unquote(numerator), unquote(denominator))
        end

      numerator when is_integer(numerator) ->
        quote do
          Ratio.new(unquote(numerator), 1)
        end

      _other ->
        raise ArgumentError, "Invalid fraction ~f'#{text}'."
    end
  end
end
