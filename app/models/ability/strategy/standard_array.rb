class Ability::Strategy::StandardArray < Ability::Strategy
  def base_scores
    [15, 14, 13, 12, 10, 8]
  end
end
