class Race::Human::Variant < Race::Human
  def ability_bonuses
    super + [[nil, 1]] * 2
  end
end
