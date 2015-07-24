class Ability::Strategy
  include ActiveModel::Model

  attr_accessor :character

  def base_scores
    Ability::STATS.map { Ability::MINIMUM_BASE }
  end

  def editable?
    false
  end

  def name
    self.class.name.demodulize.underscore
  end

  def min
    Ability::MINIMUM_BASE
  end

  def max
    Ability::MAXIMUM_BASE
  end

  def self.strategies
    @subclasses ||= Dir.glob(File.dirname(__FILE__) + "/strategy/*.rb").map do |file|
      const_get File.basename(file, ".rb").camelize
    end
  end

  def self.factory(type_name, character)
    type_name ||= "standard_array"
    type_name = type_name.to_s.camelize
    const_get(type_name).new character: character
  end
end
