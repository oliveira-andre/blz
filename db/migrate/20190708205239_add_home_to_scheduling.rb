class AddHomeToScheduling < ActiveRecord::Migration[5.2]
  def change
    add_column :schedulings, :home, :boolean
  end
end
