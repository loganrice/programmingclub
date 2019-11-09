class AddUniquenessExercises < ActiveRecord::Migration[6.0]
  def change
    remove_index :exercises, :name
    add_index :exercises, :name, unique: true
  end
end
