class CreateServices < ActiveRecord::Migration[5.2]
  def change
    create_table :services do |t|
      t.string :title, null: false
      t.integer :status, default: 2, null: false
      t.integer :local_type, null: false
      t.text :description, null: false
      t.numeric :amount, null: false
      t.integer :duration, null: false
      t.references :category, foreign_key: true
      t.references :establishment, foreign_key: true

      t.timestamps
    end
  end
end