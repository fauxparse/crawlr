class HitDie < ActiveRecord::Base
  self.table_name = "hit_dice"

  DICE_FORMAT = /\A([1-9]\d*)d([1-9]\d*)\z/

  belongs_to :character, inverse_of: :hit_dice

  after_initialize :ensure_values

  validates :level,
    presence: true,
    numericality: { greater_than: 0 },
    uniqueness: { scope: :character_id }
  validates :points,
    presence: true,
    numericality: { greater_than: 0 }
  validates :die,
    presence: { allow_blank: false },
    format: { with: DICE_FORMAT }

  validate :valid_value_for_die

  def maximum
    die =~ DICE_FORMAT
    $1.to_i * $2.to_i
  end

  def total
    points + modifier
  end

  private

  def ensure_values
    self.points ||= if level == 1
      maximum
    else
      RollDice.new(die).call
    end

    self.modifier = character.abilities.for_stat("con").modifier
  end

  def valid_value_for_die
    errors.add :points, "can't be more than #{maximum}" unless points <= maximum
  end
end
