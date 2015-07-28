class CharacterPresenter < SimpleDelegator
  def character
    __getobj__
  end

  def name
    if character.name.blank?
      character.race.random_name
    else
      character.name
    end
  end

  def description
    "Level #{level} #{race} #{character_class}"
  end

  def maximum_hit_points
    character.maximum_hit_points
  end

  def race
    RacePresenter.new character.race
  end

  def character_class
    CharacterClassPresenter.new character.character_class
  end

  def abilities
    character.abilities.sort.map { |a| AbilityPresenter.new(a) }
  end

  def ability_bonuses
    entitlements = character.ability_bonus_entitlements.sort do |a, b|
      a.first.blank? ? (b.first.blank? ? 0 : 1) : b.first.blank? ? -1 : 0
    end

    character.ability_bonuses.reject(&:marked_for_destruction?).map do |bonus|
      index = entitlements.find_index do |e|
        (e.first == bonus.stat || e.first.blank?) && e.last == bonus.bonus
      end

      index && AbilityBonusPresenter.new(bonus, entitlements[index].first.blank?)
    end.compact
  end
end
