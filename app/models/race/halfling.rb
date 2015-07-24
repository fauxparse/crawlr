class Race::Halfling < Race
  def ability_bonuses
    super + [["dex", 2]]
  end
end
