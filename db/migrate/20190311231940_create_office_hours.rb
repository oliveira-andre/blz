# frozen_string_literal: true

class CreateOfficeHours < ActiveRecord::Migration[5.2]
  def change
    create_table :office_hours do |t|
      t.integer :hour_begin, null: false
      t.integer :hour_end, null: false
      t.references :professional, foreign_key: true
      t.integer :week_day, null: false

      t.timestamps
    end
  end
end
