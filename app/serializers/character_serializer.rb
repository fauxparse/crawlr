class CharacterSerializer < ActiveModel::Serializer
  attributes :id, :abilities

  alias_method :character, :object

  def abilities
    all = character.abilities.map do |a|
      [a.stat, AbilitySerializer.new(AbilityPresenter.new(a))]
    end
    { stats: Hash[*all.flatten], strategy: ability_strategy }
  end

  def ability_strategy
    ability_strategy_serializer_for character.ability_strategy
  end

  private

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
