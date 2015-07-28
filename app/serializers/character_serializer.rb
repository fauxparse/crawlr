class CharacterSerializer < ActiveModel::Serializer
  attributes :abilities, :name, :level, :race, :character_class, :hit_points

  alias_method :character, :object

  def attributes
    super.tap do |attributes|
      attributes[:id] = object.id if object.id.present?
    end
  end

  def name
    character.name
  end

  def proficiency_bonus
    character.proficiency_bonus
  end

  def abilities
    all = character.abilities.map do |a|
      [a.stat, AbilitySerializer.new(AbilityPresenter.new(a))]
    end
    { stats: Hash[*all.flatten], strategy: ability_strategy, bonuses: ability_bonuses }
  end

  def hit_points
    { maximum: character.maximum_hit_points }
  end

  def race
    RaceSerializer.new character.race
  end

  def character_class
    CharacterClassSerializer.new character.character_class
  end

  private

  def ability_bonuses
    character.ability_bonuses
      .map { |b| Ability::BonusSerializer.new(b) }
  end

  def ability_strategy
    ability_strategy_serializer_for character.ability_strategy
  end

  def ability_strategy_serializer_for(strategy)
    klass = begin
      class_name = strategy.class.name.demodulize
      Ability::Strategy.const_get :"#{class_name}Serializer"
    rescue NameError
      Ability::StrategySerializer
    end

    klass.new strategy, character
  end
end
