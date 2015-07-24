module Races
  include ActiveSupport::Concern

  # included do
  #   validates :race_name, presence: { allow_blank: false }
  # end

  def race
    Race.factory race_name
  end
end
