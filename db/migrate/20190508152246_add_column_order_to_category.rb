class AddColumnOrderToCategory < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :order, :integer, default: 0
  end
end
