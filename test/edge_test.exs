defmodule EdgeTest do
  alias Edge.Dice.DicePool
  use ExUnit.Case
  doctest Edge.Dice

  test "Expect dicepool to succeed when given success" do
    roll_result = Edge.Dice.roll_dicepool(%DicePool{success: 1})
    roll_string = Edge.Dice.generate_string(roll_result)
    assert roll_string ==
    {%Edge.Dice.DicePool{
      sender: "Game Master",
      boost: 0,
      setback: 0,
      ability: 0,
      difficulty: 0,
      proficiency: 0,
      challenge: 0,
      force: 0,
      success: 1,
      failure: 0,
      advantage: 0,
      threat: 0,
      triumph: 0,
      despair: 0,
      light: 0,
      dark: 0
    }, "Game Master has rolled a success."}
  end

  test "Expect dicepool to fail when given failure" do
    roll_result = Edge.Dice.roll_dicepool(%DicePool{failure: 1})
    roll_string = Edge.Dice.generate_string(roll_result)
    assert roll_string ==
    {%Edge.Dice.DicePool{
      sender: "Game Master",
      boost: 0,
      setback: 0,
      ability: 0,
      difficulty: 0,
      proficiency: 0,
      challenge: 0,
      force: 0,
      success: 0,
      failure: 1,
      advantage: 0,
      threat: 0,
      triumph: 0,
      despair: 0,
      light: 0,
      dark: 0
    }, "Game Master has rolled a failure."}
  end

  test "Expect dicepool to roll" do
    roll_result = Edge.Dice.roll_dicepool(%DicePool{boost: 5, ability: 5, proficiency: 5, setback: 5, difficulty: 5, challenge: 5, force: 5})
    {%DicePool{} = dicepool, roll_string} = Edge.Dice.generate_string(roll_result)
    assert dicepool.boost == 0
    assert dicepool.ability == 0
    assert dicepool.proficiency == 0
    assert dicepool.setback == 0
    assert dicepool.difficulty == 0
    assert dicepool.challenge == 0
    assert dicepool.force == 0
    assert roll_string != "Game Master has rolled"
  end

  test "Expect added career with character creation to apply values" do
     expected_result = %Edge.Skills{astrogation: %Edge.Skill{attribute: :intellect, category: :general, rank: 1, career: true}, athletics: %Edge.Skill{attribute: :brawn, category: :general, rank: 0, career: false}, charm: %Edge.Skill{attribute: :presence, category: :general, rank: 0, career: false}, coercion: %Edge.Skill{attribute: :willpower, category: :general, rank: 0, career: false}, computers: %Edge.Skill{attribute: :intellect, category: :general, rank: 1, career: true}, cool: %Edge.Skill{attribute: :presence, category: :general, rank: 0, career: false}, coordination: %Edge.Skill{attribute: :agility, category: :general, rank: 0, career: true}, deception: %Edge.Skill{attribute: :cunning, category: :general, rank: 0, career: false}, discipline: %Edge.Skill{attribute: :willpower, category: :general, rank: 0, career: true}, leadership: %Edge.Skill{attribute: :presence, category: :general, rank: 0, career: false}, mechanics: %Edge.Skill{attribute: :intellect, category: :general, rank: 0, career: true}, medicine: %Edge.Skill{attribute: :intellect, category: :general, rank: 0, career: false}, negotiation: %Edge.Skill{attribute: :presence, category: :general, rank: 0, career: false}, perception: %Edge.Skill{attribute: :cunning, category: :general, rank: 1, career: true}, piloting_planetary: %Edge.Skill{attribute: :agility, category: :general, rank: 1, career: true}, piloting_space: %Edge.Skill{attribute: :agility, category: :general, rank: 0, career: false}, resilience: %Edge.Skill{attribute: :brawn, category: :general, rank: 0, career: false}, skulduggery: %Edge.Skill{attribute: :cunning, category: :general, rank: 0, career: false}, stealth: %Edge.Skill{attribute: :agility, category: :general, rank: 0, career: false}, streetwise: %Edge.Skill{attribute: :cunning, category: :general, rank: 0, career: false}, survival: %Edge.Skill{attribute: :cunning, category: :general, rank: 0, career: false}, vigilance: %Edge.Skill{attribute: :willpower, category: :general, rank: 0, career: false}, brawl: %Edge.Skill{attribute: :brawn, category: :combat, rank: 0, career: false}, melee: %Edge.Skill{attribute: :brawn, category: :combat, rank: 0, career: false}, ranged_light: %Edge.Skill{attribute: :agility, category: :combat, rank: 0, career: false}, ranged_heavy: %Edge.Skill{attribute: :agility, category: :combat, rank: 0, career: false}, gunnery: %Edge.Skill{attribute: :agility, category: :combat, rank: 0, career: false}, core_worlds: %Edge.Skill{attribute: :intellect, category: :knowledge, rank: 0, career: false}, education: %Edge.Skill{attribute: :intellect, category: :knowledge, rank: 0, career: false}, lore: %Edge.Skill{attribute: :intellect, category: :knowledge, rank: 0, career: false}, outer_rim: %Edge.Skill{attribute: :intellect, category: :knowledge, rank: 0, career: true}, underworld: %Edge.Skill{attribute: :intellect, category: :knowledge, rank: 0, career: false}, xenology: %Edge.Skill{attribute: :intellect, category: :knowledge, rank: 0, career: false}}

     assert %Edge.Skills{} |> Edge.Career.Technician.add([:astrogation, :computers, :perception, :piloting_planetary]) == expected_result
  end
end
