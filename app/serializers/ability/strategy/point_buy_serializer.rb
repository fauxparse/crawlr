class Ability::Strategy::PointBuySerializer < Ability::StrategySerializer
  attributes :points_remaining

  def points_remaining
    Ability::Strategy::PointBuy::POINTS_TO_SPEND - total_cost
  end

  def total_cost
    character.abilities.map(&:cost).sum
  end
end
