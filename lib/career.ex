defmodule Edge.Career do
  defmacro __using__(_opts) do
    quote do
      def career_skills(), do: :undefined

      defoverridable(career_skills: 0)

      def add_to(%Edge.Skills{} = skills) do
        add_career(skills, career_skills())
      end

      def add_to(%Edge.Skills{} = skills, selections) do
        add_career(skills, career_skills(), selections)
      end

      def is_atomlist?(list) do
        Enum.all?(list, fn el -> is_atom(el) end)
      end

      defp add_career(skills, career_list) do
        Edge.Skills.update(skills, career_list, :career, true)
      end

      defp add_career(skills, career_list, selections) do
        if Enum.all?(selections, fn el -> Enum.member?(career_list, el) end) and length(selections) == 4 do
          updated_skills = Edge.Skills.update(skills, career_list, :career, true)
          updated_skills |> Edge.Skills.add(selections, :rank, 1)
        else
          bad_selections(career_list)
        end
      end

      defp bad_selections(career_list) do
        {
          :error,
          "User selections does not match the career. Please use 4 of " <> to_string(Enum.map(career_list, fn el -> ":" <> to_string(el) <> " " end))
        }
      end
    end
  end
end
