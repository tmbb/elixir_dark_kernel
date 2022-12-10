defmodule DarkKernel.GenerateTests do
  alias DarkKernel.TestHelpers
  alias DarkKernel.TestHelpers.DarkGenerators
  require EEx

  @external_resource "scripts/templates/variable_rebinding_test.exs"
  @external_resource "scripts/templates/whitespace_insensitivity_test.exs"

  EEx.function_from_file(
    :defp,
    :variable_rebinding_test_file,
    "scripts/templates/variable_rebinding_test.exs",
    [:assigns]
  )

  EEx.function_from_file(
    :defp,
    :whitespace_insensitivity_test_file,
    "scripts/templates/whitespace_insensitivity_test.exs",
    [:assigns]
  )

  def run() do
    range_for_n = 2..12

    whitespace_sensitivity_test_cases =
      for n <- range_for_n do
        vars = TestHelpers.elixir_variables(n)
        separators = Enum.take(DarkGenerators.list_separator(), n)
        args = Enum.zip(vars, separators)

        tilde_k_with_whitespace =
          args
          |> Enum.map(fn {var, sep} -> "#{var}#{sep}" end)
          |> Enum.join("")
          |> String.trim_trailing()
          |> String.trim_trailing(",")

        tilde_k_without_whitespace = Enum.join(vars, ", ")

        %{n: n,
          vars: vars,
          with_whitespace: tilde_k_with_whitespace,
          without_whitespace: tilde_k_without_whitespace}
      end

    random_variable_test_cases =
      for n <- range_for_n do
        vars = TestHelpers.elixir_variables(n)

        comma_separated_vars = Enum.join(vars, ", ")

        comma_separated_kv_pairs =
          vars
          |> Enum.map(fn var -> "#{var}: #{var}" end)
          |> Enum.join(", ")

        comma_separate_x_kwlist =
          vars
          |> Enum.with_index(1)
          |> Enum.map(fn {var, i} -> "#{var}: var#{i}" end)
          |> Enum.join(", ")

        %{n: n,
          vars: vars,
          comma_separated_vars: comma_separated_vars,
          comma_separated_kv_pairs: comma_separated_kv_pairs,
          comma_separate_x_kwlist: comma_separate_x_kwlist}
      end

    assigns = [
      whitespace_sensitivity_test_cases: whitespace_sensitivity_test_cases,
      random_variables: random_variable_test_cases
    ]

    whitespace_insensitivity_content =
      Code.format_string!(
        whitespace_insensitivity_test_file(assigns),
        locals_without_parens: [
          all: :*
        ])

    variable_rebinding_content =
      Code.format_string!(
        variable_rebinding_test_file(assigns),
        locals_without_parens: [
          all: :*
        ])

    File.write!(
      "test/dark_kernel/dark_keywords/whitespace_insensitivity_test.exs",
      whitespace_insensitivity_content
    )

    File.write!(
      "test/dark_kernel/dark_keywords/variable_rebinding_test.exs",
      variable_rebinding_content
    )
  end
end

DarkKernel.GenerateTests.run()
