class Race::HalfElf < Race
  def ability_bonuses
    super + [["cha", 2], [nil, 1], [nil, 1]]
  end
end
