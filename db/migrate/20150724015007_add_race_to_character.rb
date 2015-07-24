class AddRaceToCharacter < ActiveRecord::Migration
  def change
    add_column :characters, :race_name, :string, default: "human/standard"
  end
end
