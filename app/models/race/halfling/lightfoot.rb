class Race::Halfling::Lightfoot < Race::Halfling
  def ability_bonuses
    super + [["cha", 1]]
  end
end
