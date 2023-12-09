defmodule DarkKernel.DarkMutableTest do
  use ExUnit.Case, async: true
  import DarkKernel

  def josevalim_example() do
  end

  def factorial_with_for_loop(n) do
    # Define a mutable variable, which is only accessible inside the block
    mutable! result: 1 do
      for i <- 1..n do
        # Update the variable in a way that's propagated "up" the AST scopes
        # in the entire `mutable!` block.
        result <<~ (result * i)
      end

      # Return the "mutable variable"
      result
    end
  end

  def factorial_with_map(n) do
    mutable! result: 1 do
      # Update the product inside a map function
      Enum.map(1..n, fn i -> result <<~ (result * i) end)

      # Return the mutable variable
      result
    end
  end

  test "factorial function with for loop works" do
    assert factorial_with_for_loop(1) == 1
    assert factorial_with_for_loop(2) == 2
    assert factorial_with_for_loop(3) == 6
    assert factorial_with_for_loop(4) == 24
    assert factorial_with_for_loop(5) == 120
  end

  test "factorial function with the map function works" do
    assert factorial_with_map(1) == 1
    assert factorial_with_map(2) == 2
    assert factorial_with_map(3) == 6
    assert factorial_with_map(4) == 24
    assert factorial_with_map(5) == 120
  end

  test "José Valim's example" do
    # The original sections, conforming to what seems to be the data format
    sections = [
      %{"lessons" => [%{"name" => "L1.1"}, %{"name" => "L1.2"}, %{"name" => "L1.3"}]},
      %{"lessons" => [%{"name" => "L2.1"}, %{"name" => "L2.2"}]},
      %{"lessons" => [%{"name" => "L3.1"}, %{"name" => "L3.2"}, %{"name" => "L3.3"}]},
      %{"lessons" => [%{"name" => "L4.1"}, %{"name" => "L4.2"}], "reset_lesson_position" => true},
      %{"lessons" => [%{"name" => "L5.1"}]}
    ]

    expected_output = [
      %{
        "lessons" => [
          %{"name" => "L1.1", "position" => 1},
          %{"name" => "L1.2", "position" => 2},
          %{"name" => "L1.3", "position" => 3}
        ],
        "position" => 1
      },
      %{
        "lessons" => [
          %{"name" => "L2.1", "position" => 4},
          %{"name" => "L2.2", "position" => 5}
        ],
        "position" => 2
      },
      %{
        "lessons" => [
          %{"name" => "L3.1", "position" => 6},
          %{"name" => "L3.2", "position" => 7},
          %{"name" => "L3.3", "position" => 8}
        ],
        "position" => 3
      },
      %{
        "lessons" => [
          # Lesson positions start to reset here:
          %{"name" => "L4.1", "position" => 1},
          %{"name" => "L4.2", "position" => 2}
        ],
        "position" => 4,
        "reset_lesson_position" => true
      },
      %{"lessons" => [%{"name" => "L5.1", "position" => 3}], "position" => 5}
    ]

    actual_output =
      mutable! section_counter: 0, lesson_counter: 0 do
        updated_sections =
          for section <- sections do
            if section["reset_lesson_position"] do
              lesson_counter <<~ 0
            end

            section_counter <<~ (section_counter + 1)

            lessons =
              for lesson <- section["lessons"] do
                lesson_counter <<~ (lesson_counter + 1)
                Map.put(lesson, "position", lesson_counter)
              end

            section
            |> Map.put("lessons", lessons)
            |> Map.put("position", section_counter)
          end

        assert section_counter == 5
        assert lesson_counter == 3
        assert updated_sections == expected_output

        # Return the result of the for loop to prove that we can get it from the outside
        updated_sections
      end

    # Assert that we are getting the right value from the mutable block
    assert actual_output == expected_output
  end
end
