class Race::Tiefling < Race
  def ability_bonuses
    super + [["cha", 2], ["int", 1]]
  end
end
