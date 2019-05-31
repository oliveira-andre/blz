class AddColumnProfileToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :profile, :integer, default: 0
  end
end
