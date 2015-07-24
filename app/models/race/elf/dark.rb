class Race::Elf::Dark < Race::Elf
  def ability_bonuses
    super + [["cha", 1]]
  end
end
