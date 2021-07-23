# frozen_string_literal: true

class AddInHomeToScheduling < ActiveRecord::Migration[5.2]
  def change
    add_column :schedulings, :in_home, :boolean
  end
end
