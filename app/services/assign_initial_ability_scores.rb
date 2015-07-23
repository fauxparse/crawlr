class AssignInitialAbilityScores
  attr_accessor :character, :strategy, :force

  def initialize(character, strategy, force = false)
    @character = character
    @strategy = strategy
    @force = force
  end

  def call
    Ability::STATS.zip(strategy.base_scores).each do |(stat, base)|
      ability = character.abilities.for_stat(stat)
      ability.base = base if force || !ability.base.present?
    end
  end
end
