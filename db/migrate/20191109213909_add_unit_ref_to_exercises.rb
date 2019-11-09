class AddUnitRefToExercises < ActiveRecord::Migration[6.0]
  def change
    add_reference :exercises, :unit, null: false, foreign_key: true
  end
end
