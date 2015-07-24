class Race::HalfOrc < Race
  def ability_bonuses
    super + [["str", 2], ["con", 1]]
  end
end
