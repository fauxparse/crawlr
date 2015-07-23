class AbilityPresenter < SimpleDelegator
  def to_s
    I18n.t("ability.stats.#{stat}")
  end

  def abbreviation
    stat.upcase
  end

  def editable?
    ability_strategy.editable?
  end

  def strategy
    ability_strategy.name
  end

  def min
    ability_strategy.min
  end

  def max
    ability_strategy.max
  end

  def ability_strategy
    @strategy ||= character.ability_strategy
  end
end
