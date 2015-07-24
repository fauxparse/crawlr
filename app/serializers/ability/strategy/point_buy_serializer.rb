class Ability::Strategy::PointBuySerializer < Ability::StrategySerializer
  attributes :points_remaining

  def points_remaining
    object.points_remaining
  end
end
