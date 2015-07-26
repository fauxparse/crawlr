class CharacterPresenter < SimpleDelegator
  def character
    __getobj__
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
