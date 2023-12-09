defmodule DarkKernel.DarkMutableBenchmark do
  import DarkKernel

  @sections List.duplicate([
    %{"lessons" => [%{"name" => "L1.1"}, %{"name" => "L1.2"}, %{"name" => "L1.3"}]},
    %{"lessons" => [%{"name" => "L2.1"}, %{"name" => "L2.2"}]},
    %{"lessons" => [%{"name" => "L3.1"}, %{"name" => "L3.2"}, %{"name" => "L3.3"}]},
    %{"lessons" => [%{"name" => "L4.1"}, %{"name" => "L4.2"}], "reset_lesson_position" => true},
    %{"lessons" => [%{"name" => "L5.1"}]}
  ], 10) |> List.flatten()

  def implementation_using_map_reduce(sections) do
    {updated_sections, _acc} =
      Enum.map_reduce(sections, {1, 1}, fn section, {section_counter, lesson_counter} ->
        lesson_counter = if section["reset_lesson_position"], do: 1, else: lesson_counter

        {lessons, lesson_counter} =
          Enum.map_reduce(section["lessons"], lesson_counter, fn lesson, lesson_counter ->
            {Map.put(lesson, "position", lesson_counter), lesson_counter + 1}
          end)

        section =
          section
          |> Map.put("lessons", lessons)
          |> Map.put("position", section_counter)

          {section, {section_counter + 1, lesson_counter}}
      end)

    updated_sections
  end

  def implementation_using_the_pdict(sections) do
    mutable! section_counter: 0, lesson_counter: 0 do
      for section <- sections do
        if section["reset_lesson_position"] do
          lesson_counter <<~ 0
        end

        section_counter <<~ section_counter + 1

        lessons =
          for lesson <- section["lessons"] do
            lesson_counter <<~ lesson_counter + 1
            Map.put(lesson, "position", lesson_counter)
          end

        section
        |> Map.put("lessons", lessons)
        |> Map.put("position", section_counter)
      end
    end
  end

  def run() do
    Benchee.run(%{
      "using_the_pdict" => fn -> implementation_using_the_pdict(@sections) end,
      "using_map_reduce" => fn -> implementation_using_map_reduce(@sections) end
    })
  end
end

DarkKernel.DarkMutableBenchmark.run()
