class AddExcludeToExercises < ActiveRecord::Migration[6.0]
  def change
    add_column :exercises, :exclude, :boolean
  end
end
