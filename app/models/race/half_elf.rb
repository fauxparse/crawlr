class Race::HalfElf < Race
  def ability_bonuses
    super + [["cha", 2], [nil, 1], [nil, 1]]
  end

  def random_name
    [Human, Elf].sample.new.random_name
  end
end
