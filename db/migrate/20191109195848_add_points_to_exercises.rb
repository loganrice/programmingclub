class AddPointsToExercises < ActiveRecord::Migration[6.0]
  def change
    add_column :exercises, :points, :integer
  end
end
