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
    has_many :abilities, inverse_of: :character do
      def for_stat(stat)
        stat = stat.to_s
        detect { |ability| ability.stat == stat }
      end
    end

    after_initialize :add_missing_abilities
  end

  protected

  def add_missing_abilities
    Ability::STATS.each do |stat|
      abilities.build stat: stat unless abilities.for_stat(stat).present?
    end
  end
end
