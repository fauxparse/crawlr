class Race::Elf::High < Race::Elf
  def ability_bonuses
    super + [["int", 1]]
  end
end
