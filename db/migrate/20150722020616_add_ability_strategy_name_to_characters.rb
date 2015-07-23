class AddAbilityStrategyNameToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :ability_strategy_name, :string
  end
end
