require "rails_helper"

RSpec.describe Character, type: :model do
  subject(:character) { Character.new }

  describe "with janky ability scores" do
    before { character.abilities.for_stat("int").stat = "str" }

    it "is invalid" do
      expect(character).not_to be_valid
    end
  end

  describe "ensures correct ability bonuses" do
    def ability_bonuses_count
      character.ability_bonuses.select { |b| !b.marked_for_destruction? }.count
    end

    before do
      character.ability_bonuses.clear
    end

    it "correctly prunes old bonuses" do
      expect(character).to receive(:ability_bonus_entitlements).and_return([["str", 1]])
      character.ability_bonuses.build stat: "str", bonus: 1
      character.ability_bonuses.build stat: "dex", bonus: 1
      expect { character.send(:ensure_correct_ability_bonuses) }.to change { ability_bonuses_count }.by(-1)
    end

    it "correctly adds new bonuses" do
      expect(character).to receive(:ability_bonus_entitlements).and_return([["str", 1], ["dex", 1]])
      character.ability_bonuses.build stat: "str", bonus: 1
      expect { character.send(:ensure_correct_ability_bonuses) }.to change { ability_bonuses_count }.by(1)
    end

    it "deals with wildcards correctly" do
      expect(character).to receive(:ability_bonus_entitlements).and_return([[nil, 1]])
      character.ability_bonuses.build stat: "str", bonus: 1
      expect { character.send(:ensure_correct_ability_bonuses) }.not_to change { ability_bonuses_count }
      expect(character.ability_bonuses.first.stat).to eq "str"
    end

    it "gives the correct bonus for an attribute" do
      expect(character).to receive(:ability_bonus_entitlements).and_return([["str", 1]])
      character.valid?
      expect(character.abilities.for_stat("str").bonus).to eq 1
      expect(character.abilities.for_stat("dex").bonus).to eq 0
    end
  end
end
