module Abilities
  extend ActiveSupport::Concern

  included do
    has_many :abilities, inverse_of: :character, autosave: true do
      def for_stat(stat)
        stat = stat.to_s
        detect { |ability| ability.stat == stat }
      end
    end

    has_many :ability_bonuses, class_name: "Ability::Bonus", inverse_of: :character, autosave: true do
      def for_stat(stat)
        stat = stat.to_s
        select { |bonus| bonus.stat == stat && !bonus.marked_for_destruction? }
      end
    end

    scope :with_abilities, -> { includes :abilities, :ability_bonuses }

    after_initialize :initialize_abilities
    after_initialize :ensure_correct_ability_bonuses
    before_validation :ensure_correct_ability_bonuses

    validates_with Ability::Validator
  end

  def ability_strategy
    Ability::Strategy.factory ability_strategy_name, self
  end

  protected

  def initialize_abilities
    Ability::STATS.each do |stat|
      abilities.build stat: stat unless abilities.for_stat(stat).present?
    end

    AssignInitialAbilityScores.new(self, ability_strategy).call
  end

  def ability_bonus_entitlements
    race.ability_bonuses
  end

  def ensure_correct_ability_bonuses
    entitlements = ability_bonus_entitlements.sort do |a, b|
      a.first.blank? ? (b.first.blank? ? 0 : 1) : b.first.blank? ? -1 : 0
    end

    remove_extra_ability_bonuses entitlements
    add_missing_ability_bonuses entitlements
  end

  def remove_extra_ability_bonuses(entitlements)
    ability_bonuses.each do |bonus|
      index = entitlements.find_index do |e|
        (e.first == bonus.stat || e.first.blank?) && e.last == bonus.bonus
      end

      if index.present?
        entitlements.delete_at index
      else
        bonus.mark_for_destruction
      end
    end
  end

  def add_missing_ability_bonuses(missing_entitlements)
    missing_entitlements.each do |e|
      ability_bonuses.build stat: e.first || primary_ability, bonus: e.last
    end
  end

  # TODO make this dynamic, based on class
  def primary_ability
    "str"
  end
end
