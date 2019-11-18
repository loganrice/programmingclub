class RemoveExcludeFromSubmissions < ActiveRecord::Migration[6.0]
  def change
    remove_column :submissions, :exclude
  end
end
