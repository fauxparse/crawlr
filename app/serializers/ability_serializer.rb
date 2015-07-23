class AbilitySerializer < ActiveModel::Serializer
  attributes :base, :modifier, :score, :strategy, :min, :max

  def strategy
    object.character.ability_strategy_name
  end

  def min
    object.min
  end

  def max
    object.max
  end
end
