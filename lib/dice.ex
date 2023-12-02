defmodule Edge.Dice do

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
      success: 0,
      failure: 0,
      advantage: 0,
      threat: 0,
      triumph: 0,
      despair: 0,
      light: 0,
      dark: 0
    ]
  end

  def roll_dicepool(%DicePool{} = dicepool) when dicepool.boost > 0 do
    dicepool
    |> roll_dice(:boost)
    |> remove_dice(:boost)
    |> roll_dicepool()
  end

  def roll_dicepool(%DicePool{} = dicepool) when dicepool.ability > 0 do
    dicepool
    |> roll_dice(:ability)
    |> remove_dice(:ability)
    |> roll_dicepool()
  end

  def roll_dicepool(%DicePool{} = dicepool) when dicepool.proficiency > 0 do
    dicepool
    |> roll_dice(:proficiency)
    |> remove_dice(:proficiency)
    |> roll_dicepool()
  end

  def roll_dicepool(%DicePool{} = dicepool) when dicepool.setback > 0 do
    dicepool
    |> roll_dice(:setback)
    |> remove_dice(:setback)
    |> roll_dicepool()
  end

  def roll_dicepool(%DicePool{} = dicepool) when dicepool.difficulty > 0 do
    dicepool
    |> roll_dice(:difficulty)
    |> remove_dice(:difficulty)
    |> roll_dicepool()
  end

  def roll_dicepool(%DicePool{} = dicepool) when dicepool.challenge > 0 do
    dicepool
    |> roll_dice(:challenge)
    |> remove_dice(:challenge)
    |> roll_dicepool()
  end

  def roll_dicepool(%DicePool{} = dicepool) when dicepool.force > 0 do
    dicepool
    |> roll_dice(:force)
    |> remove_dice(:force)
    |> roll_dicepool()
  end

  def roll_dicepool(%DicePool{} = dicepool) do
    dicepool
    |> remove_wash()
  end

  def roll_dicepool(dicepool) do
    struct(DicePool, dicepool)
    |> roll_dicepool
  end

  def generate_string(%DicePool{} = dicepool) do
    {dicepool, "#{dicepool.sender} has rolled "}
    |> generate_success_failure_string()
    |> generate_advantage_threat_string()
    |> generate_triumph_despair_string()
    |> generate_light_dark_string()

  end

  defp generate_success_failure_string({%DicePool{} = dicepool, result}) when dicepool.success == 0 and dicepool.failure == 0 do
    {dicepool, result <> "a failure wash"}
  end

  defp generate_success_failure_string({%DicePool{} = dicepool, result}) when dicepool.success == 1 do
    {dicepool, result <> "a success"}
  end

  defp generate_success_failure_string({%DicePool{} = dicepool, result}) when dicepool.success > 0 do
    {dicepool, result <> "#{dicepool.success} successes"}
  end

  defp generate_success_failure_string({%DicePool{} = dicepool, result}) when dicepool.failure == 1 do
    {dicepool, result <> "a failure"}
  end

  defp generate_success_failure_string({%DicePool{} = dicepool, result}) when dicepool.failure > 1 do
    {dicepool, result <> "#{dicepool.failure} failures"}
  end

  defp generate_advantage_threat_string({%DicePool{} = dicepool, result}) when dicepool.advantage == 0 and dicepool.threat == 0 do
    {dicepool, result}
  end

  defp generate_advantage_threat_string({%DicePool{} = dicepool, result}) when dicepool.advantage == 1 do
    {dicepool, result <> ", an advantage"}
  end

  defp generate_advantage_threat_string({%DicePool{} = dicepool, result}) when dicepool.advantage > 1 do
    {dicepool, result <> ", #{dicepool.advantage} advantages"}
  end

  defp generate_advantage_threat_string({%DicePool{} = dicepool, result}) when dicepool.threat == 1 do
    {dicepool, result <> ", a threat"}
  end

  defp generate_advantage_threat_string({%DicePool{} = dicepool, result}) when dicepool.threat > 1 do
    {dicepool, result <> ", #{dicepool.threat} threat"}
  end

  defp generate_triumph_despair_string({%DicePool{} = dicepool, result}) when dicepool.triumph > 1 and dicepool.despair > 1 do
    {dicepool, result <> " with #{dicepool.triumph} triumphs and #{dicepool.despair} despairs!"}
  end

  defp generate_triumph_despair_string({%DicePool{} = dicepool, result}) when dicepool.triumph == 1 and dicepool.despair > 1 do
    {dicepool, result <> " with a triumph and #{dicepool.despair} despairs!"}
  end

  defp generate_triumph_despair_string({%DicePool{} = dicepool, result}) when dicepool.triumph > 1 and dicepool.despair == 1 do
    {dicepool, result <> " with #{dicepool.triumph} triumphs and a despair!"}
  end

  defp generate_triumph_despair_string({%DicePool{} = dicepool, result}) when dicepool.triumph == 1 do
    {dicepool, result <> " and a triumph!"}
  end

  defp generate_triumph_despair_string({%DicePool{} = dicepool, result}) when dicepool.triumph > 1 do
    {dicepool, result <> " and #{dicepool.triumph} triumphs!"}
  end

  defp generate_triumph_despair_string({%DicePool{} = dicepool, result}) when dicepool.despair == 1 do
    {dicepool, result <> " and a despair!"}
  end

  defp generate_triumph_despair_string({%DicePool{} = dicepool, result}) when dicepool.despair > 1 do
    {dicepool, result <> " and #{dicepool.despair} despair!"}
  end

  defp generate_triumph_despair_string({%DicePool{} = dicepool, result}) when dicepool.triumph == 0 and dicepool.despair == 0 do
    {dicepool, result <> "."} # Honestly, just cap it off here.
  end

  defp generate_light_dark_string({%DicePool{} = dicepool, result}) when dicepool.light == 1 do
    {dicepool, result <> " There was a single lightside point."}
  end

  defp generate_light_dark_string({%DicePool{} = dicepool, result}) when dicepool.light > 1 do
    {dicepool, result <> " There were #{dicepool.light} lightside points."}
  end

  defp generate_light_dark_string({%DicePool{} = dicepool, result}) when dicepool.dark == 1 do
    {dicepool, result <> " There was a single darkside point."}
  end

  defp generate_light_dark_string({%DicePool{} = dicepool, result}) when dicepool.dark > 1 do
    {dicepool, result <> " There were #{dicepool.dark} darkside points."}
  end

  defp generate_light_dark_string({%DicePool{} = dicepool, result}) when dicepool.light == 0 and dicepool.dark == 0 do
    {dicepool, result}
  end

  defp remove_wash(dicepool) do

    {success, failure} =
      if dicepool.success > dicepool.failure do
        {dicepool.success - dicepool.failure, 0}
      else
        {0, dicepool.failure - dicepool.success}
      end

    {advantage, threat} =
      if dicepool.advantage > dicepool.threat do
        {dicepool.advantage - dicepool.threat, 0}
      else
        {0, dicepool.threat - dicepool.advantage}
      end

    {light, dark} =
      if dicepool.light > dicepool.dark do
        {dicepool.light - dicepool.dark, 0}
      else
        {0, dicepool.dark - dicepool.light}
      end

    dicepool
    |> Map.replace(:advantage, advantage)
    |> Map.replace(:threat, threat)
    |> Map.replace(:success, success)
    |> Map.replace(:failure, failure)
    |> Map.replace(:light, light)
    |> Map.replace(:dark, dark)

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
      12 -> dicepool |> add_result(:triumph, 1) |> add_result(:success, 1)
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
      12 -> dicepool |> add_result(:despair, 1) |> add_result(:failure, 1)
      _ -> dicepool
    end
  end

  defp roll_dice(%DicePool{} = dicepool, :force) do
    case :rand.uniform(12) do
      1 -> dicepool |> add_result(:dark, 1)
      2 -> dicepool |> add_result(:dark, 1)
      3 -> dicepool |> add_result(:dark, 1)
      4 -> dicepool |> add_result(:dark, 1)
      5 -> dicepool |> add_result(:dark, 1)
      6 -> dicepool |> add_result(:dark, 1)
      7 -> dicepool |> add_result(:dark, 2)
      8 -> dicepool |> add_result(:light, 1)
      9 -> dicepool |> add_result(:light, 1)
      10 -> dicepool |> add_result(:light, 2)
      11 -> dicepool |> add_result(:light, 2)
      12 -> dicepool |> add_result(:light, 2)
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
