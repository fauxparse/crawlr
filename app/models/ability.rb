class Ability < ActiveRecord::Base
  STATS = %w(str con dex int wis cha).freeze
  MINIMUM_SCORE = 8
  MAXIMUM_SCORE = 30

  belongs_to :character, inverse_of: :abilities

  validates :stat,
    inclusion: { in: STATS },
    uniqueness: { scope: :character_id }
  validates :base,
    presence: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: MINIMUM_SCORE,
      less_than_or_equal_to: MAXIMUM_SCORE
    }

  def score
    base
  end

  def cost
    base - 8
  end

  def modifier
    score / 2 - 5
  end
end
