class AddLevelToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :level, :integer, null: false, default: 1
  end
end
