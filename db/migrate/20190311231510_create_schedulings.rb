class CreateSchedulings < ActiveRecord::Migration[5.2]
  def change
    create_table :schedulings do |t|
      t.references :user, foreign_key: true
      t.references :professional_service, foreign_key: true
      t.integer :status, default: 0
      t.integer :service_duration, null: false
      t.datetime :date, null: false
      t.timestamps
    end
  end
end
