class CreateEstablishments < ActiveRecord::Migration[5.2]
  def change
    create_table :establishments do |t|
      t.string :name, null: false
      t.string :timetable, null: false
      t.integer :status, default: 0
      t.references :user, foreign_key: true
      t.integer :self_employed, null: false
      t.timestamps
    end
  end
end
