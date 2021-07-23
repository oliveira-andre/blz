# frozen_string_literal: true

class AddStartWithToServices < ActiveRecord::Migration[5.2]
  def self.up
    add_column :services, :start_from, :boolean, default: false
  end
end
