class CreateSchedulings < ActiveRecord::Migration[5.2]
  def change
    create_table :schedulings do |t|
      t.references :user, foreign_key: true
      t.references :service, foreign_key: true
      t.integer :status, default: 0
      t.timestamp :begin_time, null: false
      t.timestamp :end_time, null: false
      t.timestamps
    end
  end
end
