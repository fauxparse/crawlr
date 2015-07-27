class AddCharacterClassToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :character_class_name, :string, null: false, default: "fighter"
  end
end
