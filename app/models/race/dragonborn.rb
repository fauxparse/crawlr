class Race::Dragonborn < Race
  def ability_bonuses
    super + [["str", 2], ["cha", 1]]
  end
end
