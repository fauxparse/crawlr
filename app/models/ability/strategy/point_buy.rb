class Ability::Strategy::PointBuy < Ability::Strategy
  POINTS_TO_SPEND = 27 # Player’s Handbook p13

  def base_scores
    Ability::STATS.map { 8 }
  end

  def editable?
    true
  end

  def min
    8
  end

  def max
    15
  end

  def points_remaining
    POINTS_TO_SPEND - total_cost
  end

  def total_cost
    character.abilities.map(&:cost).sum
  end
end
