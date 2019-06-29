class AddCancelFieldsToSchedulings < ActiveRecord::Migration[5.2]
  def change
    add_column :schedulings, :canceled_at, :datetime
    add_column :schedulings, :canceled_reason, :text
    add_column :schedulings, :canceled_by, :integer
  end
end
