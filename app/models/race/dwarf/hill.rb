class Race::Dwarf::Hill < Race::Dwarf
  def ability_bonuses
    super + [["wis", 1]]
  end
end
