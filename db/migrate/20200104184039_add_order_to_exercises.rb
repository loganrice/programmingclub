class AddOrderToExercises < ActiveRecord::Migration[6.0]
  def change
    add_column :exercises, :order, :int
  end
end
