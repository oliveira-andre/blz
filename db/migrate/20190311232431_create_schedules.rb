class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.boolean :free, default: true
      t.timestamp :date, null: false
      t.references :professional_service, foreign_key: true

      t.timestamps
    end
  end
end
