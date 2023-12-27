defmodule Edge.Skill do
  defstruct characteristic: :unset, category: :unset, rank: 0, career: false
  def new(characteristic \\ :unset, category \\ :unset, rank \\ 0, career \\ false) do
    %Edge.Skill{characteristic: characteristic, category: category, rank: rank, career: career}
  end

  def update(%Edge.Skill{} = skill, rank \\ 0, career \\ false) do
    %{skill | rank: rank, career: career}
  end

end

defmodule Edge.Skills do
  defstruct [
    astrogation: %Edge.Skill{characteristic: :intellect, category: :general},
    athletics: %Edge.Skill{characteristic: :brawn, category: :general},
    charm: %Edge.Skill{characteristic: :presence, category: :general},
    coercion: %Edge.Skill{characteristic: :willpower, category: :general},
    computers: %Edge.Skill{characteristic: :intellect, category: :general},
    cool: %Edge.Skill{characteristic: :presence, category: :general},
    coordination: %Edge.Skill{characteristic: :agility, category: :general},
    deception: %Edge.Skill{characteristic: :cunning, category: :general},
    discipline: %Edge.Skill{characteristic: :willpower, category: :general},
    leadership: %Edge.Skill{characteristic: :presence, category: :general},
    mechanics: %Edge.Skill{characteristic: :intellect, category: :general},
    medicine: %Edge.Skill{characteristic: :intellect, category: :general},
    negotiation: %Edge.Skill{characteristic: :presence, category: :general},
    perception: %Edge.Skill{characteristic: :cunning, category: :general},
    piloting_planetary: %Edge.Skill{characteristic: :agility, category: :general},
    piloting_space: %Edge.Skill{characteristic: :agility, category: :general},
    resilience: %Edge.Skill{characteristic: :brawn, category: :general},
    skulduggery: %Edge.Skill{characteristic: :cunning, category: :general},
    stealth: %Edge.Skill{characteristic: :agility, category: :general},
    streetwise: %Edge.Skill{characteristic: :cunning, category: :general},
    survival: %Edge.Skill{characteristic: :cunning, category: :general},
    vigilance: %Edge.Skill{characteristic: :willpower, category: :general},
    brawl: %Edge.Skill{characteristic: :brawn, category: :combat},
    melee: %Edge.Skill{characteristic: :brawn, category: :combat},
    ranged_light: %Edge.Skill{characteristic: :agility, category: :combat},
    ranged_heavy: %Edge.Skill{characteristic: :agility, category: :combat},
    gunnery: %Edge.Skill{characteristic: :agility, category: :combat},
    core_worlds: %Edge.Skill{characteristic: :intellect, category: :knowledge},
    education: %Edge.Skill{characteristic: :intellect, category: :knowledge},
    lore: %Edge.Skill{characteristic: :intellect, category: :knowledge},
    outer_rim: %Edge.Skill{characteristic: :intellect, category: :knowledge},
    underworld: %Edge.Skill{characteristic: :intellect, category: :knowledge},
    xenology: %Edge.Skill{characteristic: :intellect, category: :knowledge}
  ]

  def update(%Edge.Skills{} = skills, skill, key, value) when is_atom(skill) do
    put_in(skills, [Access.key!(skill), Access.key!(key)], value)
  end

  def update(%Edge.Skills{} = skills, [], _key, _value) do
    skills
  end

  def update(%Edge.Skills{} = skills, skill_list, key, value) when is_list(skill_list) do
    [head | tail] = skill_list

    skills
    |> update(head, key, value)
    |> update(tail, key, value)
  end
end
