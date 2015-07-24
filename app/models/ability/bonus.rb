class Ability::Bonus < ActiveRecord::Base
  self.table_name = "ability_bonuses"

  belongs_to :character, inverse_of: :ability_bonuses
end
