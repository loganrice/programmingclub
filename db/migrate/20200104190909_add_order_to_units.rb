class AddOrderToUnits < ActiveRecord::Migration[6.0]
  def change
    add_column :units, :order, :int
  end
end
