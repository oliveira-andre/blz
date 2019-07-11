# frozen_string_literal: true

class CreateReportSchedulingProblems < ActiveRecord::Migration[5.2]
  def self.up
    create_table :report_scheduling_problems do |t|
      t.integer :category, null: false
      t.text :body
      t.references :user, null: false

      t.timestamp
    end
  end

  def self.down
    drop_table :report_scheduling_problems
  end
end
