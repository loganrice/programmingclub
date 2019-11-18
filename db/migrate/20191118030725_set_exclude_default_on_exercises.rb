class SetExcludeDefaultOnExercises < ActiveRecord::Migration[6.0]
  def change
    change_column_default :exercises, :exclude, false
  end
end
