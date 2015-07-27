class Character < ActiveRecord::Base
  include Abilities
  include Races
  include Classes

  validates :name, presence: { allow_blank: false }

  scope :most_recent_first, -> { order updated_at: :desc }
end
