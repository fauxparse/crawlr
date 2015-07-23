class Ability::StrategySerializer < ActiveModel::Serializer
  attributes :name, :editable

  attr_reader :character

  def initialize(strategy, character)
    super strategy
    @character = character
  end

  def name
    object.name
  end

  def editable
    object.editable?
  end
end
