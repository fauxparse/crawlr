class Race::Human::Standard < Race::Human
  def ability_bonuses
    super + Ability::STATS.map { |stat| [stat, 1] }
  end
end
