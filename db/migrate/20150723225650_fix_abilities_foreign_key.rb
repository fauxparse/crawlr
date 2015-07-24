class FixAbilitiesForeignKey < ActiveRecord::Migration
  def up
    remove_foreign_key :abilities, :characters
    add_foreign_key :abilities, :characters, on_delete: :cascade
  end

  def down
    remove_foreign_key :abilities, :characters
    add_foreign_key :abilities, :characters
  end
end
