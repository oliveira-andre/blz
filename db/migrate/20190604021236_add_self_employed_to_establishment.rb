# frozen_string_literal: true

class AddSelfEmployedToEstablishment < ActiveRecord::Migration[5.2]
  def change
    add_column :establishments, :self_employed, :boolean, default: false
  end
end
