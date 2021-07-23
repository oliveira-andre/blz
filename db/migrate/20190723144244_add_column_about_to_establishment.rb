# frozen_string_literal: true

class AddColumnAboutToEstablishment < ActiveRecord::Migration[5.2]
  def change
    add_column :establishments, :about, :text
  end
end
