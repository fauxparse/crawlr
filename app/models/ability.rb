class Ability < ActiveRecord::Base
  STATS = %w(str dex con int wis cha).freeze
  MINIMUM_BASE = 3
  MAXIMUM_BASE = 18

  belongs_to :character, inverse_of: :abilities

  validates :stat,
    inclusion: { in: STATS },
    uniqueness: { scope: :character_id }
  validates :base,
    presence: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: MINIMUM_BASE,
      less_than_or_equal_to: MAXIMUM_BASE
    }

  def score
    base + bonus
  end

  def bonus
    character.ability_bonuses.for_stat(stat).map(&:bonus).sum
  end

  def cost
    if base < 14
      base - 8
    else
      (base - 13) * 2 + 5
    end
  end

  def modifier
    score / 2 - 5
  end

  def <=>(another)
    STATS.index(stat) <=> STATS.index(another.stat)
  end
end
