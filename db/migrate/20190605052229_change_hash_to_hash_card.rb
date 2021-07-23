# frozen_string_literal: true

class ChangeHashToHashCard < ActiveRecord::Migration[5.2]
  def change
    rename_column :payment_cards, :hash, :hash_card
  end
end
