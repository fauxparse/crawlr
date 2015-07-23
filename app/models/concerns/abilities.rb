module Abilities
  extend ActiveSupport::Concern

  class AbilitiesValidator < ActiveModel::Validator
    def validate(record)
      unless abilities.map(&:stat).sort == Ability::STATS.sort
        record.add_error :abilities, :bad_abilities
      end
    end
  end

  included do
    has_many :abilities, inverse_of: :character, autosave: true do
      def for_stat(stat)
        stat = stat.to_s
        detect { |ability| ability.stat == stat }
      end
    end

    after_initialize :initialize_abilities
  end

  def ability_strategy
    Ability::Strategy.factory ability_strategy_name
  end

  protected

  def initialize_abilities
    Ability::STATS.each do |stat|
      abilities.build stat: stat unless abilities.for_stat(stat).present?
    end

    AssignInitialAbilityScores.new(self, ability_strategy).call
  end
end
