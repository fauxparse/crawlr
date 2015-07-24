class Race::Dwarf < Race
  def ability_bonuses
    super + [["con", 2]]
  end
end
