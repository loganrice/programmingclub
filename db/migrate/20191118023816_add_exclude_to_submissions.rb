class AddExcludeToSubmissions < ActiveRecord::Migration[6.0]
  def change
    add_column :submissions, :exclude, :boolean
  end
end
