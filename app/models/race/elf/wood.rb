class Race::Elf::Wood < Race::Elf
  def ability_bonuses
    super + [["wis", 1]]
  end
end
