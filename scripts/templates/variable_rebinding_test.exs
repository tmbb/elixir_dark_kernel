defmodule DarkKernel.DarkKeywords.VariableRebindingTest do
  use ExUnit.Case, async: true
  import ExUnitProperties
  import StreamData

  import DarkKernel

  <%= for {test_case, index} <- Enum.with_index(@random_variables, 1) do %>
  test "variable rebinding, example #<%= index %>: <%= test_case.n %> variables" do<%
    first_name = hd(test_case.vars)
    rest_of_the_names = tl(test_case.vars)
  %>
    check all <%= first_name %> <- term()<%= for name <- rest_of_the_names do %>,
              <%= name %> <- term()<% end %><%= for i <- 1..length(test_case.vars) do %>,
              var<%= i %> <- term()<% end %> do

      # Keyword lists built with ~k[] have the value we expect:
      # -------------------------------------------------------
      assert ~k[<%= test_case.comma_separated_vars %>] == [<%= test_case.comma_separated_kv_pairs %>]

      # Test that variables are rebound successfully:
      # ---------------------------------------------

      # 1) Rebind the variables
      ~k[<%= test_case.comma_separated_vars %>] = [<%= test_case.comma_separate_x_kwlist %>]

      # 2) Assert that each variable has the correct value<%=
      for {name, index} <- Enum.with_index(test_case.vars, 1) do %>
      assert <%= name %> == var<%= index %><% end %>
    end
  end
  <% end %>
end
