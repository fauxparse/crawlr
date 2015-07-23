require "rails_helper"

RSpec.describe AbilitiesHelper, type: :helper do
  describe "#signed" do
    it "displays negative numbers with a minus sign" do
      expect(helper.signed(-1)).to eq "-1"
    end

    it "displays positive numbers with a plus sign" do
      expect(helper.signed(1)).to eq "+1"
    end
  end
end
