# Edge

**Setup instructions**

Add {Edge.Dice, nil} to your /lib/(application name)/application.ex file's children like so:

```elixir
children = [
      # Starts a worker by calling: Edge.Worker.start_link(arg)
      {Edge.Dice, nil}
    ]
```

You can roll by calling the GenServer using the following:
`GenServer.call(Edge.Dice, {:readable, %Edge.Dice.DicePool{ability: 3, proficiency: 4, setback: 2, difficulty: 3, challenge: 2}})`
> "Game Master rolled 3 successes, a threat."

To get the raw results, you can pass in `:raw` instead of a `:readable` string.
`GenServer.call(Edge.Dice, {:raw, %Edge.Dice.DicePool{ability: 1, difficulty: 1}})`
> %Edge.Dice.DicePool{sender: "Game Master", boost: 0, setback: 0, ability: 0, difficulty: 0, proficiency: 0, challenge: 0, force: 0, advantage: 0, threat: 0, success: 0, failure: 1, triumph: 0, despair: 0}

Important to note that dice are 'washed'- That is, if you generate 1 success and 1 failure, they will both cancel each other out and end up at 0- A failed roll. Same goes for advantage and disadvantage.

The DicePool struct contains the following default values. Changing them will change what dice is rolled and will modify your final roll calculation.
```elixir
defmodule DicePool do
    defstruct [
      sender: "Game Master",
      boost: 0,
      setback: 0,
      ability: 0,
      difficulty: 0,
      proficiency: 0,
      challenge: 0,
      force: 0,
      advantage: 0,
      threat: 0,
      success: 0,
      failure: 0,
      triumph: 0,
      despair: 0
    ]
  end
```
For example, if we made a dice pool like #Edge.Dice.DicePool{ability: 1, failure: 500} you would fail the roll all the time, because after the ability dice is rolled, you may still have 498 leftover failures from the modified roll. These may be from talents or (if you're like me and you like to fudge rolls a little) from environmental conditions.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `edge` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:edge, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/edge>.

