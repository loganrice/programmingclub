class CreateExercises < ActiveRecord::Migration[6.0]
  def change
    create_table :exercises do |t|
      t.string :name
      t.string :link

      t.timestamps
    end
    add_index :exercises, :name
  end
end
