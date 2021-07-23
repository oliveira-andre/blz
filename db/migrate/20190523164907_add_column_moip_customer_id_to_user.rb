# frozen_string_literal: true

class AddColumnMoipCustomerIdToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :moip_customer_id, :string
  end
end
