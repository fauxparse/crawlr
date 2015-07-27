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
    character.ensure_correct_ability_bonuses
  end

  def level=(value)
    character.level = value
  end

  def abilities=(values)
    self.ability_strategy = values[:strategy]

    values[:stats].each_pair do |stat, data|
      if data[:strategy] == ability_strategy_name
        abilities.for_stat(stat).base = data[:base]
      end
    end

    self.ability_bonuses = values[:bonuses]
  end

  def ability_strategy=(strategy)
    name = strategy[:name]

    character.ability_strategy_name = name
    AssignInitialAbilityScores.new(character, ability_strategy, true).call
  end

  def ability_bonuses=(bonuses)
    bonuses.each_with_index do |bonus, index|
      ability_bonus = character.ability_bonuses[index] || character.ability_bonuses.build
      ability_bonus.stat = bonus[:stat]
      ability_bonus.bonus = bonus[:bonus].to_i
    end
  end

  def self.permitted_attributes
    [].tap do |attributes|
      abilities = {}.tap do |hash|
        Ability::STATS.each do |stat|
          hash[stat.to_sym] = [ :base, :strategy ]
        end
      end

      attributes << { abilities: { stats: abilities, strategy: [ :name ], bonuses: [:bonus, :stat] } }
      attributes << :level
      attributes << :race_name
    end
  end
end
