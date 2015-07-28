class CreateHitDice < ActiveRecord::Migration
  def change
    create_table :hit_dice do |t|
      t.belongs_to :character
      t.integer :level, null: false
      t.integer :points, null: false
      t.integer :modifier, null: false
      t.string :die, null: false
    end

    add_foreign_key :hit_dice, :characters, on_delete: :cascade
  end
end
