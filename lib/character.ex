defmodule Edge.Character do
  defstruct [
    name: "",
    species: "",
    characteristics: %{
      brawn: %Edge.Characteristic{},
      agiity: %Edge.Characteristic{},
      intellect: %Edge.Characteristic{},
      cunning: %Edge.Characteristic{},
      willpower: %Edge.Characteristic{},
      presence: %Edge.Characteristic{}
    },
    skills: %Edge.Skills{},
    careers: [],
    specializations: [],
    #weapons: [],
    #talents?????
  ]

  def set_characteristic_rank(%Edge.Character{} = character, characteristic, value) when is_atom(characteristic) do
    put_in(character, [
      Access.key!(:characteristics),
      Access.key!(characteristic),
      Access.key!(:rank)
      ], value)
  end

  def set_skill_rank(%Edge.Character{} = character, skill, value) when is_atom(skill) do
    %{character | skills: Edge.Skills.update(character.skills, skill, :rank, value)}
  end
end
