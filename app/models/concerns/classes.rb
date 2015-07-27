module Classes
  extend ActiveSupport::Concern

  included do
    validates :character_class_name, presence: { allow_blank: false }
  end

  def character_class
    CharacterClass.factory character_class_name
  end
end
