# frozen_string_literal: true

class AddStatusToReview < ActiveRecord::Migration[5.2]
  def self.up
    add_column :reviews, :status, :integer, default: 0
  end

  def self.down
    remove_column :reviews, :status
  end
end
