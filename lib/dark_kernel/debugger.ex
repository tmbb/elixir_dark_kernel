defmodule DarkKernel.Debugger do
  @moduledoc """
  Utilities to debug generated code
  """
  require Logger

  def active?() do
    Application.get_env(:dark_kernel, :debugger_active, false)
  end

  @doc false
  def put_activity(value) do
    Application.put_env(:dark_kernel, :debugger_active, value)
  end

  def activate_debugger() do
    put_activity(true)
  end

  def deactivate_debugger() do
    put_activity(false)
  end

  @doc false
  def maybe_debug_ast(text, ast, env) do
    if active?() do
      generated_code =
        ast
        |> Macro.to_string()
        |> Code.format_string!()
        |> to_string()

      table = three_sided_cells([
        {header_color("⤷ Code:"), bottom_line_style: :dashed},
        code_color(text),
        {header_color("⤷ Generated code:"), bottom_line_style: :dashed},
        code_color(generated_code),
        {header_color("⤷ Generated AST:"), bottom_line_style: :dashed},
        code_color(inspect(ast, pretty: true))
      ])

      relative_filename = Path.relative_to_cwd(env.file)
      location = "#{relative_filename}:#{env.line}"

      Logger.debug([
        location,
        "\n",
        table
      ])
    end
  end


  # ────────────────────────────────────────────────
  # Table formatting
  # ────────────────────────────────────────────────

  @default_table_width 100


  def color_with(text, color, previous_color \\ IO.ANSI.cyan()) do
    text
    |> String.split("\n")
    |> Enum.map(fn line -> [color, line, previous_color] end)
    |> Enum.intersperse("\n")
    |> to_string()
  end

  defp header_color(text) do
    color_with(text, IO.ANSI.green())
  end

  defp code_color(text) do
    color_with(text, IO.ANSI.blue())
  end


  defp three_sided_cell(content, options) do
    padding = Keyword.get(options, :padding, 1)
    width = Keyword.get(options, :width, @default_table_width)
    bottom? = Keyword.get(options, :bottom?, false)
    top? = Keyword.get(options, :top?, false)

    bottom_line_style = Keyword.get(options, :bottom_line_style, :solid)
    top_line_style = Keyword.get(options, :top_line_style, :solid)

    v_padding = List.duplicate("│\n", padding - 1)
    h_padding = List.duplicate("", padding)

    nw_corner =
      case top? do
        true -> "┌"
        false -> "├"
      end

    sw_corner =
      case bottom? do
        true -> "└"
        false -> "├"
      end


    as_table_cell_content =
      content
      |> String.split("\n")
      |> Enum.map(fn line -> ["│ ", h_padding, line, "\n"] end)

    [
      (if top?, do: [nw_corner, hline(top_line_style, width), "\n"], else: []),
      v_padding,
      as_table_cell_content,
      v_padding,
      [sw_corner, hline(bottom_line_style, width), "\n"],
    ]
  end

  defp three_sided_cells(cells_content, options \\ []) do
    maximum_width =
      cells_content
      |> Enum.flat_map(fn
          {cell, _opts} -> String.split(cell, "\n")
          cell -> String.split(cell, "\n")
        end)
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
        {cell, options_for_cell} =
          case cell do
            {cell, opts} -> {cell, opts}
            cell -> {cell, []}
          end

        opts = Keyword.merge(options, options_for_cell)

        cond do
          index == 0 ->
            {cell, Keyword.put(opts, :top?, true)}

          index == nr_of_cells - 1 ->
            {cell, Keyword.put(opts, :bottom?, true)}

          true ->
            {cell, opts}
        end
      end

    Enum.map(cells_with_options, fn {cell, opts} ->
      three_sided_cell(cell, opts)
    end)
  end

  defp hline(:solid, width), do: List.duplicate("─", width)
  defp hline(:dashed, width), do: List.duplicate("╶", width)
end
