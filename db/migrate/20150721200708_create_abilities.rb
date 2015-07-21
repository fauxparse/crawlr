class CreateAbilities < ActiveRecord::Migration
  def change
    create_table :abilities do |t|
      t.belongs_to :character
      t.string :stat, limit: 3, null: false
      t.integer :base, null: false
    end

    add_foreign_key :abilities, :characters
  end
end
