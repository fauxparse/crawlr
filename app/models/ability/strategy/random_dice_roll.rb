class Ability::Strategy::RandomDiceRoll < Ability::Strategy
  def base_scores
    Ability::STATS.map { RollDice.new('4d6/3').call }
  end
end
