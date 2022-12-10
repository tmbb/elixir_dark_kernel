defmodule DarkKernel.DarkKeywords.WhitespaceInsensitivityTest do
  use ExUnit.Case, async: true
  import ExUnitProperties
  import StreamData

  import DarkKernel

  # ----------------------------------------------
  # ~k[] lists are not whitespace sensitive
  # ----------------------------------------------

  <%= for {test_case, index} <- Enum.with_index(@whitespace_sensitivity_test_cases, 1) do %>
  test "~k[] are whitespace insensitive, example #<%= index %>: <%= test_case.n %> variables" do<%
    first_name = hd(test_case.vars)
    rest_of_the_names = tl(test_case.vars)
  %>
    check all <%= first_name %> <- term()<%= for name <- rest_of_the_names do %>,
              <%= name %> <- term()<% end %> do
      # Check for equality with different amounts of whitespace
      assert ~k[<%= test_case.without_whitespace %>] == ~k[<%= test_case.with_whitespace %>]
    end
  end<% end %>
end
