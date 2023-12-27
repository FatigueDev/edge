# defmodule Edge.Career do
#   defmacro __using__(career_skills: career_skills) do
#     quote do

#       @career_skills unquote(career_skills)

#       def add(%Edge.Skills{} = skills) do
#         Edge.Skills.update(skills, @career_skills, :career, true)
#       end

#       def add(%Edge.Skills{} = skills, character_creation_selections) do
#         if Enum.all?(character_creation_selections, fn el -> Enum.member?(@career_skills, el) end)
#         and length(character_creation_selections) == 4
#         and Enum.all?(character_creation_selections, fn el -> is_atom(el) end) do
#           updated_skills = Edge.Skills.update(skills, @career_skills, :career, true)
#           updated_skills |> Edge.Skills.add(character_creation_selections, :rank, 1)
#         else
#           {
#             :error,
#             "User selections does not match the career. Please use 4 of " <> to_string(Enum.map(@career_skills, fn el -> ":" <> to_string(el) <> " " end))
#           }
#         end
#       end
#     end
#   end
# end
