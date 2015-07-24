class CharacterForm < SimpleDelegator
  attr_accessor :character

  def initialize(character, params = {})
    __setobj__ @character = character

    params.each do |attr, value|
      self.public_send("#{attr}=", value)
    end if params
  end

  def race_name=(value)
    character.race_name = value
    character.send :ensure_correct_ability_bonuses
  end

  def abilities=(values)
    self.ability_strategy = values[:strategy]

    values[:stats].each_pair do |stat, data|
      if data[:strategy] == ability_strategy_name
        abilities.for_stat(stat).base = data[:base]
      end
    end
  end

  def ability_strategy=(strategy)
    name = strategy[:name]

    @character.ability_strategy_name = name
    AssignInitialAbilityScores.new(@character, ability_strategy, true).call
  end

  def self.permitted_attributes
    [].tap do |attributes|
      abilities = {}.tap do |hash|
        Ability::STATS.each do |stat|
          hash[stat.to_sym] = [ :base, :strategy ]
        end
      end

      attributes << { abilities: { stats: abilities, strategy: [ :name ] } }
      attributes << :race_name
    end
  end
end
