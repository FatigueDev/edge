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
end
