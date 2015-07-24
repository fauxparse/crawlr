class Race::Halfling::Stout < Race::Halfling
  def ability_bonuses
    super + [["con", 1]]
  end
end
