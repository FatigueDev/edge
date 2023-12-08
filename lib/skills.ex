defmodule Edge.Skill do
  defstruct attribute: :unset, category: :unset, rank: 0, career: false
  def new(attribute \\ :unset, category \\ :unset, rank \\ 0, career \\ false) do
    %Edge.Skill{attribute: attribute, category: category, rank: rank, career: career}
  end

  def update(%Edge.Skill{} = skill, rank \\ 0, career \\ false) do
    %{skill | rank: rank, career: career}
  end

end

defmodule Edge.Skills do
  defstruct [
    astrogation: %Edge.Skill{attribute: :intellect, category: :general},
    athletics: %Edge.Skill{attribute: :brawn, category: :general},
    charm: %Edge.Skill{attribute: :presence, category: :general},
    coercion: %Edge.Skill{attribute: :willpower, category: :general},
    computers: %Edge.Skill{attribute: :intellect, category: :general},
    cool: %Edge.Skill{attribute: :presence, category: :general},
    coordination: %Edge.Skill{attribute: :agility, category: :general},
    deception: %Edge.Skill{attribute: :cunning, category: :general},
    discipline: %Edge.Skill{attribute: :willpower, category: :general},
    leadership: %Edge.Skill{attribute: :presence, category: :general},
    mechanics: %Edge.Skill{attribute: :intellect, category: :general},
    medicine: %Edge.Skill{attribute: :intellect, category: :general},
    negotiation: %Edge.Skill{attribute: :presence, category: :general},
    perception: %Edge.Skill{attribute: :cunning, category: :general},
    piloting_planetary: %Edge.Skill{attribute: :agility, category: :general},
    piloting_space: %Edge.Skill{attribute: :agility, category: :general},
    resilience: %Edge.Skill{attribute: :brawn, category: :general},
    skulduggery: %Edge.Skill{attribute: :cunning, category: :general},
    stealth: %Edge.Skill{attribute: :agility, category: :general},
    streetwise: %Edge.Skill{attribute: :cunning, category: :general},
    survival: %Edge.Skill{attribute: :cunning, category: :general},
    vigilance: %Edge.Skill{attribute: :willpower, category: :general},
    brawl: %Edge.Skill{attribute: :brawn, category: :combat},
    melee: %Edge.Skill{attribute: :brawn, category: :combat},
    ranged_light: %Edge.Skill{attribute: :agility, category: :combat},
    ranged_heavy: %Edge.Skill{attribute: :agility, category: :combat},
    gunnery: %Edge.Skill{attribute: :agility, category: :combat},
    core_worlds: %Edge.Skill{attribute: :intellect, category: :knowledge},
    education: %Edge.Skill{attribute: :intellect, category: :knowledge},
    lore: %Edge.Skill{attribute: :intellect, category: :knowledge},
    outer_rim: %Edge.Skill{attribute: :intellect, category: :knowledge},
    underworld: %Edge.Skill{attribute: :intellect, category: :knowledge},
    xenology: %Edge.Skill{attribute: :intellect, category: :knowledge}
  ]

  def add(%Edge.Skills{} = skills, skill, key, value) when is_atom(skill) do
    previous = get_in(skills, [Access.key!(skill), Access.key!(key)])
    put_in(skills, [Access.key!(skill), Access.key!(key)], previous + value)
  end

  def add(%Edge.Skills{} = skills, [], _key, _value)do
    skills
  end

  def add(%Edge.Skills{} = skills, skill_list, key, value) when is_list(skill_list) do
    [head | tail] = skill_list

    skills
    |> add(head, key, value)
    |> add(tail, key, value)
  end

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
