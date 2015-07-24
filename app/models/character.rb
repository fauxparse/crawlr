class Character < ActiveRecord::Base
  include Abilities
  include Races

  scope :most_recent_first, -> { order updated_at: :desc }
end
