class CharacterForm < SimpleDelegator
  def initialize(character, params = {})
    __setobj__ character

    if params
      params.each do |attr, value|
        self.public_send("#{attr}=", value)
      end
    end
  end

  def character
    __getobj__
  end

  def present
    CharacterPresenter.new character
  end

  def name=(value)
    character.name = value
  end

  def race=(value)
    race_name = value[:name]
    if character.new_record? || character.race_name != race_name
      character.race_name = race_name
      character.ensure_correct_ability_bonuses
    end
  end

  def character_class=(value)
    character_class_name = value[:name]
    character.character_class_name = character_class_name
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
    (bonuses || []).each_with_index do |bonus, index|
      ability_bonus = character.ability_bonuses.reject(&:marked_for_destruction?)[index] ||
        character.ability_bonuses.build
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

      attributes << :name
      attributes << :level
      attributes << { race: [ :name ] }
      attributes << { character_class: [ :name ] }
      attributes << { abilities: { stats: abilities, strategy: [ :name ], bonuses: [ :bonus, :stat ] } }
    end
  end

  def self.wrapped_parameters
    permitted_attributes.map do |attribute|
      attribute.try(:keys) || attribute
    end.flatten
  end
end
