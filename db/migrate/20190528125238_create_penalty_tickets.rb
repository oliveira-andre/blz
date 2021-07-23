# frozen_string_literal: true

class CreatePenaltyTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :penalty_tickets do |t|
      t.references :scheduling, foreign_key: true
      t.string :moip_order_id
      t.integer :amount, null: false
      t.integer :status, default: 0
      t.integer :kind, default: 0

      t.timestamps
    end
  end
end
