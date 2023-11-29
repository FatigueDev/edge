# Edge

## Setup instructions

You can roll by calling `Edge.Dice.roll_dicepool()` with something like the following:
`Edge.Dice.roll_dicepool(%Edge.Dice.DicePool{boost: 5, difficulty: 1, ability: 3, proficiency: 3, challenge: 1})`
That may spit out an `Edge.Dice.DicePool` that looks like this:
```elixir
%Edge.Dice.DicePool{
  sender: "Game Master",
  boost: 0,
  setback: 0,
  ability: 0,
  difficulty: 0,
  proficiency: 0,
  challenge: 0,
  force: 0,
  success: 3,
  failure: 0,
  advantage: 2,
  threat: 0,
  triumph: 1,
  despair: 1,
  light: 0,
  dark: 0
}
```
You can pipe an `Edge.Dice.DicePool` into the `Edge.Dice.generate_string(dicepool)` function to receive a tuple of {%DicePool, result_string}. This could look like the following:

`Edge.Dice.roll_dicepool(%Edge.Dice.DicePool{boost: 5, difficulty: 1, ability: 3, proficiency: 3, challenge: 1}) |> Edge.Dice.generate_string()`
```elixir
{%Edge.Dice.DicePool{
   sender: "Game Master",
   boost: 0,
   setback: 0,
   ability: 0,
   difficulty: 0,
   proficiency: 0,
   challenge: 0,
   force: 0,
   success: 2,
   failure: 0,
   advantage: 11,
   threat: 0,
   triumph: 1,
   despair: 0,
   light: 0,
   dark: 0
 }, "Game Master has rolled 2 successes, 11 advantages and a triumph!"}
 ```

A clean way to capture the results is to receive the tuple from the `generate_string` function like so:
`{%Edge.Dice.DicePool{} = dicepool, result_string} = Edge.Dice.roll_dicepool(%Edge.Dice.DicePool{}) |> Edge.Dice.generate_string()`
Using that method will let us have quicker access to the values of the struct like dicepool.success, dicepool.triumph etc.

Important to note that dice are 'washed'- That is, if you generate 1 success and 1 failure, they will both cancel each other out and end up at 0- A failed roll. Same goes for advantage and disadvantage. Additionally, the dicepool that you pass to the `Edge.Dice.roll_dicepool` function works by rolling the dice and removing it from the dice pool. Seeing all of your dice in the result as 0 is normal, as that means they have been rolled.

If we made a dice pool like `%Edge.Dice.DicePool{ability: 1, failure: 500}` you would fail the roll all the time, because after the ability dice is rolled, you may still have 498 leftover failures from the modified roll. These may be from talents or (if you're like me and you like to fudge rolls a little) from environmental conditions.

## Installation

You can install this dice roller by adding this git repo to your `deps` section.

```elixir
def deps do
  [
    {:edge, git: "https://github.com/veliandev/edge.git"}
  ]
end
```
