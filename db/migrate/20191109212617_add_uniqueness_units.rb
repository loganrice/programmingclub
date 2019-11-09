class AddUniquenessUnits < ActiveRecord::Migration[6.0]
  def change
    remove_index :units, :name
    add_index :units, :name, unique: true
  end
end
