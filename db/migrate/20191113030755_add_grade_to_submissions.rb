class AddGradeToSubmissions < ActiveRecord::Migration[6.0]
  def change
    add_column :submissions, :graded_points, :integer 
  end
end
