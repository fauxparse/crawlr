require 'rails_helper'

RSpec.describe Ability, type: :model do
  it {
    is_expected.to validate_numericality_of(:base)
      .only_integer
      .is_greater_than_or_equal_to(8)
      .is_less_than_or_equal_to(30)
  }

  it { is_expected.to validate_inclusion_of(:stat).in_array(Ability::STATS) }

  describe '#modifier' do
    modifiers = {
       8 => -1,  9 => -1,
      10 =>  0, 11 =>  0,
      12 =>  1, 13 =>  1,
      14 =>  2, 15 =>  2,
      16 =>  3, 17 =>  3,
      18 =>  4
    }

    modifiers.each_pair do |score, modifier|
      it "is #{modifier} for a score of #{score}" do
        expect(Ability.new(base: score).modifier).to eq modifier
      end
    end
  end
end
