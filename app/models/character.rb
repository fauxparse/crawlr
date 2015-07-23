class Character < ActiveRecord::Base
  include Abilities

  scope :most_recent_first, -> { order updated_at: :desc }
end
