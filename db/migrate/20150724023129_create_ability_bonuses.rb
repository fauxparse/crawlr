class CreateAbilityBonuses < ActiveRecord::Migration
  def change
    create_table :ability_bonuses do |t|
      t.belongs_to :character
      t.string :stat, limit: 3
      t.integer :bonus
    end

    add_foreign_key :ability_bonuses, :characters, on_delete: :cascade
  end
end
