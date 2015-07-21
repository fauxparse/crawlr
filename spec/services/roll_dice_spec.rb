require 'rails_helper'

RSpec.describe RollDice do
  it 'raises an error for bad formats' do
    expect { RollDice.new('1d').call }.to raise_error ArgumentError
  end

  it 'accepts ‘best of’ rolls' do
    expect { RollDice.new('4d6/3').call }.not_to raise_error
  end

  it 'accepts multiple dice/constants' do
    expect { RollDice.new('1d8 + 1d4 + 2').call }.not_to raise_error
  end
end
