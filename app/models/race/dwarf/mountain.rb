class Race::Dwarf::Mountain < Race::Dwarf
  def ability_bonuses
    super + [["str", 2]]
  end
end
