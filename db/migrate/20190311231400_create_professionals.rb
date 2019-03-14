class CreateProfessionals < ActiveRecord::Migration[5.2]
  def change
    create_table :professionals do |t|
      t.string :name, null: false
      t.text :description
      t.references :establishment, foreign_key: true

      t.timestamps
    end
  end
end
