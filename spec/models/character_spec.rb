require "rails_helper"

RSpec.describe Character, type: :model do
  subject(:character) { Character.new }

  describe "with janky ability scores" do
    before { character.abilities.for_stat("int").stat = "str" }

    it "is invalid" do
      expect(character).not_to be_valid
    end
  end
end
