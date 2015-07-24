class Race::Elf < Race
  def ability_bonuses
    super + [["dex", 2]]
  end
end
