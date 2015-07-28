module HitPoints
  extend ActiveSupport::Concern

  included do
    has_many :hit_dice, class_name: "HitDie", inverse_of: :character, autosave: true

    before_validation :ensure_correct_hit_dice

    validates_associated :hit_dice
  end

  def maximum_hit_points
    ensure_correct_hit_dice
    hit_dice.map(&:total).sum
  end

  private

  def ensure_correct_hit_dice
    hit_dice.select do |die|
      die.level > level
    end.map(&:mark_for_destruction)

    (1..level).each do |l|
      d = hit_dice.detect { |d| d.level == l && !d.marked_for_destruction? } ||
        hit_dice.build(level: l, modifier: abilities.for_stat("con").modifier)
      d.die = character_class.hit_die
      d.validate
    end
  end
end
