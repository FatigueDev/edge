defmodule Edge.Dice do
  use GenServer

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

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  @impl true
  def init(arg) do
    {:ok, arg}
  end

  @impl true
  def handle_call({:raw, roll_request}, _, state) do
    {:reply, roll_dicepool(roll_request), state}
  end

  @impl true
  def handle_call({:readable, roll_request}, _, state) do
    result = roll_dicepool(roll_request) |> generate_string()
    {:reply, result, state}
  end

  def roll_dicepool(dicepool) when dicepool.boost > 0 do
    dicepool
    |> roll_dice(:boost)
    |> remove_dice(:boost)
    |> roll_dicepool()
  end

  def roll_dicepool(dicepool) when dicepool.ability > 0 do
    dicepool
    |> roll_dice(:ability)
    |> remove_dice(:ability)
    |> roll_dicepool()
  end

  def roll_dicepool(dicepool) when dicepool.proficiency > 0 do
    dicepool
    |> roll_dice(:proficiency)
    |> remove_dice(:proficiency)
    |> roll_dicepool()
  end

  def roll_dicepool(dicepool) when dicepool.setback > 0 do
    dicepool
    |> roll_dice(:setback)
    |> remove_dice(:setback)
    |> roll_dicepool()
  end

  def roll_dicepool(dicepool) when dicepool.difficulty > 0 do
    dicepool
    |> roll_dice(:difficulty)
    |> remove_dice(:difficulty)
    |> roll_dicepool()
  end

  def roll_dicepool(dicepool) when dicepool.challenge > 0 do
    dicepool
    |> roll_dice(:challenge)
    |> remove_dice(:challenge)
    |> roll_dicepool()
  end

  def roll_dicepool(dicepool) do
    dicepool
    |> remove_wash()
  end

  defp remove_wash(dicepool) do
    {advantage, threat} = if dicepool.advantage > dicepool.threat do {dicepool.advantage - dicepool.threat, 0} else {0, dicepool.threat - dicepool.advantage} end
    {success, failure} = if dicepool.success > dicepool.failure do {dicepool.success - dicepool.failure, 0} else {0, dicepool.failure - dicepool.success} end

    dicepool
    |> Map.replace(:advantage, advantage)
    |> Map.replace(:threat, threat)
    |> Map.replace(:success, success)
    |> Map.replace(:failure, failure)
  end

  defp generate_string(dicepool) do
    result_string = "#{dicepool.sender} rolled "
    result_string = if dicepool.success > 0 do result_string <> "#{if dicepool.success == 1 do "a success" else "#{dicepool.success} successes" end}" else result_string end
    result_string = if dicepool.success == 0 && dicepool.failure == 0 do result_string <> "a failed roll" else result_string end
    result_string = if dicepool.failure > 0 do result_string <> "#{if dicepool.failure == 1 do "a failure" else "#{dicepool.failure} failures" end}" else result_string end
    result_string = if dicepool.advantage > 0 do result_string <> ", #{if dicepool.advantage == 1 do "an advantage" else "#{dicepool.advantage} advantages" end}" else result_string end
    result_string = if dicepool.threat > 0 do result_string <> ", #{if dicepool.threat == 1 do "a threat" else "#{dicepool.threat} threats" end}" else result_string end
    result_string = if dicepool.triumph > 0 do result_string <> " and #{if dicepool.triumph == 1 do "a triumph" else "#{dicepool.triumph} triumphs" end}" else result_string end
    result_string = if dicepool.despair > 0 do result_string <> " and #{if dicepool.despair == 1 do "a despair" else "#{dicepool.despair} despairs" end}" else result_string end
    result_string = if dicepool.triumph == 0 and dicepool.despair == 0 do result_string <> "." else result_string <> "!" end
    result_string
  end

  defp roll_dice(%DicePool{} = dicepool, :boost) do
    case :rand.uniform(6) do
      3 -> dicepool |> add_result(:advantage, 2)
      4 -> dicepool |> add_result(:advantage, 1)
      5 -> dicepool |> add_result(:advantage, 1) |> add_result(:success, 1)
      6 -> dicepool |> add_result(:success, 1)
      _ -> dicepool
    end
  end

  defp roll_dice(%DicePool{} = dicepool, :ability) do
    case :rand.uniform(8) do
      2 -> dicepool |> add_result(:success, 1)
      3 -> dicepool |> add_result(:success, 1)
      4 -> dicepool |> add_result(:success, 2)
      5 -> dicepool |> add_result(:advantage, 1)
      6 -> dicepool |> add_result(:advantage, 1)
      7 -> dicepool |> add_result(:success, 1) |> add_result(:advantage, 1)
      8 -> dicepool |> add_result(:advantage, 2)
      _ -> dicepool
    end
  end

  defp roll_dice(%DicePool{} = dicepool, :proficiency) do
    case :rand.uniform(12) do
      2 -> dicepool |> add_result(:success, 1)
      3 -> dicepool |> add_result(:success, 1)
      4 -> dicepool |> add_result(:success, 2)
      5 -> dicepool |> add_result(:success, 2)
      6 -> dicepool |> add_result(:advantage, 1)
      7 -> dicepool |> add_result(:success, 1) |> add_result(:advantage, 1)
      8 -> dicepool |> add_result(:success, 1) |> add_result(:advantage, 1)
      9 -> dicepool |> add_result(:success, 1) |> add_result(:advantage, 1)
      10 -> dicepool |> add_result(:advantage, 2)
      11 -> dicepool |> add_result(:advantage, 2)
      12 -> dicepool |> add_result(:triumph, 2)
      _ -> dicepool
    end
  end

  defp roll_dice(%DicePool{} = dicepool, :setback) do
    case :rand.uniform(6) do
      3 -> dicepool |> add_result(:failure, 1)
      4 -> dicepool |> add_result(:failure, 1)
      5 -> dicepool |> add_result(:threat, 1)
      6 -> dicepool |> add_result(:threat, 1)
      _ -> dicepool
    end
  end

  defp roll_dice(%DicePool{} = dicepool, :difficulty) do
    case :rand.uniform(8) do
      2 -> dicepool |> add_result(:failure, 1)
      3 -> dicepool |> add_result(:failure, 2)
      4 -> dicepool |> add_result(:threat, 1)
      5 -> dicepool |> add_result(:threat, 1)
      6 -> dicepool |> add_result(:threat, 1)
      7 -> dicepool |> add_result(:threat, 2)
      8 -> dicepool |> add_result(:failure, 1) |> add_result(:threat, 1)
      _ -> dicepool
    end
  end

  defp roll_dice(%DicePool{} = dicepool, :challenge) do
    case :rand.uniform(12) do
      2 -> dicepool |> add_result(:failure, 1)
      3 -> dicepool |> add_result(:failure, 1)
      4 -> dicepool |> add_result(:failure, 2)
      5 -> dicepool |> add_result(:failure, 2)
      6 -> dicepool |> add_result(:threat, 1)
      7 -> dicepool |> add_result(:threat, 1)
      8 -> dicepool |> add_result(:failure, 1) |> add_result(:threat, 1)
      9 -> dicepool |> add_result(:failure, 1) |> add_result(:threat, 1)
      10 -> dicepool |> add_result(:threat, 2)
      11 -> dicepool |> add_result(:threat, 2)
      12 -> dicepool |> add_result(:despair, 1)
      _ -> dicepool
    end
  end

  defp remove_dice(dicepool, dice) do
    dicepool
    |> Map.update!(dice, fn val -> val - 1 end)
  end

  defp add_result(dicepool, type, count) do
    dicepool
    |> Map.update!(type, fn val -> val + count end)
  end

end
